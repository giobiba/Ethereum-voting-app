pragma solidity ^0.8.13;

contract Voting {

    bytes32[] public listaCandidati;

    mapping (bytes32 => uint256) public voturiCandidati;


    constructor(bytes32[] memory numeCandidati) public {
        listaCandidati = numeCandidati;
    }

    function totalVoturi(bytes32 numeCandidat) view public returns (uint256) {
        require(validareCandidat(numeCandidat));
        return voturiCandidati[numeCandidat];
    }


    function vot(bytes32 numeCandidat) public {
        require(validareCandidat(numeCandidat));
        voturiCandidati[numeCandidat]++;
    }

    function validareCandidat(bytes32 numeCandidat) view public returns (bool) {
    for(uint i = 0; i < listaCandidati.length; i++) {
      if (listaCandidati[i] == numeCandidat) {
        return true;
      }
    }
    return false;
  }
}

/*
candidati = ['Macron', 'Le Pen', 'Melenchon']
deployedContract.deploy({
    data:bytecode, 
    arguments: [candidati.map(name => web3.utils.asciiToHex(name))]
}).send({
    from: '..some eth account..', 
    gas:1500000, 
    gasPrice: web3.utils.toWei('0.00003', 'ether')
    }).then((newContractInstance) => {
        deployedContract.options.address = newContractInstance.options.address
        console.log(newContractInstance.options.address)
    });


*/

