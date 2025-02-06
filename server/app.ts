// === app.ts ===
document.addEventListener("DOMContentLoaded", () => {
  const hairSelect = document.getElementById("hairColor") as HTMLSelectElement;
  const weaponSelect = document.getElementById(
    "weaponType"
  ) as HTMLSelectElement;
  const updateButton = document.getElementById(
    "updateNFT"
  ) as HTMLButtonElement;
  const preview = document.getElementById("nftPreview") as HTMLImageElement;

  function updatePreview() {
    const hair = hairSelect.value;
    const weapon = weaponSelect.value;
    preview.src = `/api/nft/1?hair_color=${hair}&weapon_type=${weapon}`;
  }

  hairSelect.addEventListener("change", updatePreview);
  weaponSelect.addEventListener("change", updatePreview);
  updateButton.addEventListener("click", async () => {
    // Here you would add the code to interact with the Sui contract
    console.log("Updating NFT on blockchain...");
  });

  // Initial preview
  updatePreview();
});
