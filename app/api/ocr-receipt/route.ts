import Anthropic from "@anthropic-ai/sdk";
import { createClient } from "@/utils/supabase/server";

const SUPPORTED_TYPES = new Set(["image/jpeg", "image/png", "image/gif", "image/webp"]);
const MAX_BYTES = 5 * 1024 * 1024; // 5 MB

export async function POST(request: Request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }

  const formData = await request.formData();
  const file = formData.get("file");

  if (!(file instanceof File)) {
    return Response.json({ error: "No file provided." }, { status: 400 });
  }

  if (!SUPPORTED_TYPES.has(file.type)) {
    return Response.json({ error: "Only JPEG, PNG, GIF, or WEBP images are supported." }, { status: 400 });
  }

  const bytes = await file.arrayBuffer();

  if (bytes.byteLength > MAX_BYTES) {
    return Response.json({ error: "Image exceeds 5 MB limit." }, { status: 400 });
  }

  const base64 = Buffer.from(bytes).toString("base64");
  const mediaType = file.type as "image/jpeg" | "image/png" | "image/gif" | "image/webp";

  const client = new Anthropic();

  const message = await client.messages.create({
    model: "claude-haiku-4-5-20251001",
    max_tokens: 512,
    messages: [
      {
        role: "user",
        content: [
          {
            type: "image",
            source: { type: "base64", media_type: mediaType, data: base64 },
          },
          {
            type: "text",
            text: `Extract data from this receipt for a used car dealership expense system.
Respond with a single JSON object and no other text:
{
  "amount": <final total as a number, null if not found>,
  "vendor": <store or vendor name as a string, null if not found>,
  "date": <date in YYYY-MM-DD format, null if not found>,
  "category": <best fit from: "REPAIR", "PARTS", "FUEL", "DETAIL", "TRANSPORTATION", "TITLE_FEE", "INSPECTION", "OTHER_DIRECT_COST" — or null>,
  "memo": <one short sentence describing what was purchased, null if unclear>
}`,
          },
        ],
      },
    ],
  });

  const rawText = message.content[0].type === "text" ? message.content[0].text.trim() : "{}";

  try {
    const jsonMatch = rawText.match(/\{[\s\S]*\}/);
    const data = JSON.parse(jsonMatch ? jsonMatch[0] : rawText);
    return Response.json(data);
  } catch {
    return Response.json({ error: "Could not parse OCR result." }, { status: 500 });
  }
}
