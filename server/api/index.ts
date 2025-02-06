import express from "express";
import { generateNFTImage } from "../image-generator";

const app = express();
app.use(express.json());

const PORT = 3000;

app.get("/api/nft/:tokenId", async (req, res) => {
  const { tokenId } = req.params;
  const { hair_color, weapon_type } = req.query;

  try {
    const svg = await generateNFTImage(
      String(hair_color || "black"),
      String(weapon_type || "sword")
    );

    res.setHeader("Content-Type", "image/svg+xml");
    res.send(svg);
  } catch (error) {
    res.status(500).send("Error generating image");
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
