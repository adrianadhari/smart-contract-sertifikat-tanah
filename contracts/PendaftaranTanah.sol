// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PendaftaranTanah {
    struct Sertifikat {
        string nomorSertifikat; // Nomor sertifikat tanah
        string cidIpfs; // CID IPFS tempat dokumen disimpan
        string nib; // Nomor Induk Bidang
        string pemegangHak; // Nama pemegang hak atas tanah
        uint256 waktuTerdaftar; // Timestamp pencatatan
    }

    mapping(string => Sertifikat) public dataSertifikat;
    address public pemilikKontrak;

    event SertifikatTerdaftar(
        string nomorSertifikat,
        string cidIpfs,
        string nib,
        string pemegangHak,
        uint256 waktuTerdaftar
    );

    modifier hanyaPemilik() {
        require(
            msg.sender == pemilikKontrak,
            "Hanya pemilik kontrak yang bisa melakukan aksi ini"
        );
        _;
    }

    constructor() {
        pemilikKontrak = msg.sender;
    }

    function daftarSertifikat(
        string memory _nomorSertifikat,
        string memory _cidIpfs,
        string memory _nib,
        string memory _pemegangHak
    ) public hanyaPemilik {
        require(
            bytes(dataSertifikat[_nomorSertifikat].nomorSertifikat).length == 0,
            "Sertifikat sudah terdaftar"
        );

        dataSertifikat[_nomorSertifikat] = Sertifikat({
            nomorSertifikat: _nomorSertifikat,
            cidIpfs: _cidIpfs,
            nib: _nib,
            pemegangHak: _pemegangHak,
            waktuTerdaftar: block.timestamp
        });

        emit SertifikatTerdaftar(
            _nomorSertifikat,
            _cidIpfs,
            _nib,
            _pemegangHak,
            block.timestamp
        );
    }

    function verifikasiSertifikat(
        string memory _nomorSertifikat
    )
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            uint256
        )
    {
        require(
            bytes(dataSertifikat[_nomorSertifikat].nomorSertifikat).length > 0,
            "Sertifikat tidak ditemukan"
        );
        Sertifikat memory s = dataSertifikat[_nomorSertifikat];
        return (
            s.nomorSertifikat,
            s.cidIpfs,
            s.nib,
            s.pemegangHak,
            s.waktuTerdaftar
        );
    }
}
