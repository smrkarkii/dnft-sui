
// === image-generator.ts ===
import fs from 'fs/promises';
import path from 'path';

export async function generateNFTImage(
    hairColor: string,
    weaponType: string
): Promise<string> {
    // Read base SVG components
    const basePath = path.join(__dirname, './assets');
    const [base, hair, weapon] = await Promise.all([
        fs.readFile(path.join(basePath, 'base.svg'), 'utf-8'),
        fs.readFile(path.join(basePath, `hair_${hairColor}.svg`), 'utf-8'),
        fs.readFile(path.join(basePath, `weapon_${weaponType}.svg`), 'utf-8'),
    ]);

    // Extract inner content from component SVGs
    const extractContent = (svg: string) => {
        const match = svg.match(/<svg[^>]*>([\s\S]*?)<\/svg>/i);
        return match ? match[1] : '';
    };

    // Combine components
    const combinedSVG = `
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 500">
            ${extractContent(base)}
            ${extractContent(hair)}
            ${extractContent(weapon)}
        </svg>
    `;

    return combinedSVG;
}
