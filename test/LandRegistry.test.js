const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("LandRegistry", function () {
  let LandRegistry;
  let landRegistry;
  let owner;
  let addr1;

  beforeEach(async function () {
    // Deploy contract
    LandRegistry = await ethers.getContractFactory("LandRegistry");
    [owner, addr1] = await ethers.getSigners();
    landRegistry = await LandRegistry.deploy();
  });

  it("Should register a certificate", async function () {
    const landNumber = "12345";
    const ipfsCID = "QmExampleCID";

    // Register certificate
    await landRegistry.connect(owner).registerCertificate(landNumber, ipfsCID);

    // Verify certificate
    const certificate = await landRegistry.verifyCertificate(landNumber);
    expect(certificate[0]).to.equal(landNumber); // Periksa landNumber
    expect(certificate[1]).to.equal(ipfsCID);   // Periksa ipfsCID
    expect(certificate[2]).to.be.above(0);      // Periksa timestamp
  });

  it("Should not allow non-owner to register a certificate", async function () {
    const landNumber = "12345";
    const ipfsCID = "QmExampleCID";

    // Try to register certificate with non-owner
    await expect(
      landRegistry.connect(addr1).registerCertificate(landNumber, ipfsCID)
    ).to.be.revertedWith("Only the owner can perform this action");
  });
});