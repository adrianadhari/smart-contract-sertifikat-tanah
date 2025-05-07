const { ethers } = require("hardhat");

async function main() {
    // Alamat smart contract di jaringan Base Sepolia
    const contractAddress = "0x1f12aae5158Eb02e3d2fE987fb0affD0D498bE56";

    // Hubungkan ke jaringan Base Sepolia
    const provider = new ethers.JsonRpcProvider("https://sepolia.base.org");
    const privateKey = "dffe3b5415847cb4ad39ad1bf30a10364736fe101c7148c1a91282a47a10e9b8";
    
    // Inisialisasi wallet dengan provider
    const owner = new ethers.Wallet(privateKey, provider);

    // Hubungkan ke smart contract
    const contract = new ethers.Contract(contractAddress, [
        "function registerCertificate(string memory _landNumber, string memory _ipfsCID) external",
    ], owner);  

    // Nomor sertifikat dan CID yang ingin diuji
    const landNumber = "212310035";
    const ipfsCID = "QmRandomCID123";

    try {
        // Estimasi gas untuk pendaftaran sertifikat
        const gasUsed = await contract.registerCertificate.estimateGas(landNumber, ipfsCID);
        console.log(`Estimasi Gas untuk ${landNumber}: ${gasUsed.toString()}`);
    } catch (error) {
        console.error("Estimasi Gas Gagal:", error.reason || error.message);
    }
}

main().catch((error) => {
    console.error("Error:", error);
});
