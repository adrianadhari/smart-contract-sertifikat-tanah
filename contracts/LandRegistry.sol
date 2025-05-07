// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract LandRegistry {
    struct Certificate {
        string landNumber;  // Nomor sertifikat tanah
        string ipfsCID;     // CID IPFS tempat sertifikat disimpan
        uint256 timestamp;  // Waktu pencatatan
    }

    mapping(string => Certificate) public certificates;
    address public owner;

    event CertificateRegistered(string landNumber, string ipfsCID, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerCertificate(string memory _landNumber, string memory _ipfsCID) public onlyOwner {
        require(bytes(certificates[_landNumber].landNumber).length == 0, "Certificate already registered");
        
        certificates[_landNumber] = Certificate({
            landNumber: _landNumber,
            ipfsCID: _ipfsCID,
            timestamp: block.timestamp
        });

        emit CertificateRegistered(_landNumber, _ipfsCID, block.timestamp);
    }

    function verifyCertificate(string memory _landNumber) public view returns (string memory, string memory, uint256) {
        require(bytes(certificates[_landNumber].landNumber).length > 0, "Certificate not found");
        Certificate memory cert = certificates[_landNumber];
        return (cert.landNumber, cert.ipfsCID, cert.timestamp);
    }
}
