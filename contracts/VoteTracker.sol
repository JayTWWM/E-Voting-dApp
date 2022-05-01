pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;
import "./VoteLibrary.sol";

contract VoteTracker
{
    bytes32 adminKey = 0xc888c9ce9e098d5864d3ded6ebcc140a12142263bace3a23a36f9905f12bd64a;

    mapping(uint => VoteLibrary.Vote) public VoteStore;
    uint256 public voterCount = 0;

    mapping(uint => VoteLibrary.Party) public PartyStore;
    uint256 public partyCount = 0;

    mapping(uint => VoteLibrary.Identity) public IdentityStore;
    uint256 public identityCount = 0;

    function registerUser(string memory _email, string memory _birthdate, string memory _gender, string memory _affiliation, string memory _state) public returns(uint256)
    {
        require(checkIfIdCanExist(_email));
        identityCount++;
        IdentityStore[identityCount] = VoteLibrary.Identity(_email, _birthdate, _gender, _affiliation, _state);
        emit IdentityCreate(_email, _birthdate, _gender, _affiliation, _state);
    }

    function verifyUser(string memory _email) public returns(bool)
    {
        require(!checkIfIdCanExist(_email));

        return true;
    }

    function generateVote(string memory _partyName, string memory email, string memory _constituency) public returns(uint256)
    {
        require(!checkIfIdCanExist(email));
        require(checkIfCanVote(email));
        require(!checkIfCanExist(_partyName));
        voterCount++;
        VoteStore[voterCount] = VoteLibrary.Vote(voterCount, block.timestamp, _partyName, email, _constituency);
        uint partyIndex = getParty(_partyName);
        PartyStore[partyIndex].voteCount++;
        emit VoteGenerate(voterCount, block.timestamp, _partyName, email, _constituency);
    }
    
    function createParty(string memory _name) public returns(uint256)
    {
        require(checkIfCanExist(_name));
        partyCount++;
        PartyStore[partyCount] = VoteLibrary.Party(_name, 0);
        emit PartyCreate(_name, 0);
    }

    function verifyAdminKey(string memory _key) public returns(bool)
    {
        require(adminKey == keccak256(abi.encodePacked(_key)));
        
        return true;
    }

    function checkIfCanExist(string memory _namer) private returns(bool)
    {
        for(uint i=1;i<=partyCount;i++)
        {
            string memory partyNamed = PartyStore[i].name;
            if(keccak256(abi.encodePacked((partyNamed))) == keccak256(abi.encodePacked((_namer))))
            {
                return false;
            }
        }
        return true;
    }

    function checkIfIdCanExist(string memory _namered) private returns(bool)
    {
        for(uint i=1;i<=identityCount;i++)
        {
            string memory idNamed = IdentityStore[i].email;
            if(keccak256(abi.encodePacked((idNamed))) == keccak256(abi.encodePacked((_namered))))
            {
                return false;
            }
        }
        return true;
    }

    function checkIfCanVote(string memory _adhaarer) private returns(bool)
    {
        for(uint i=1;i<=voterCount;i++)
        {
            string memory voteNamed = VoteStore[i].adhaar;
            if(keccak256(abi.encodePacked((voteNamed))) == keccak256(abi.encodePacked((_adhaarer))))
            {
                return false;
            }
        }
        return true;
    }

    function getParty(string memory _partyNamer) private returns (uint)
    {
        for(uint i=1;i<=partyCount;i++)
        {
            string memory partyNamed = PartyStore[i].name;
            if(keccak256(abi.encodePacked((partyNamed))) == keccak256(abi.encodePacked((_partyNamer))))
            {
                return i;
            }
        }
    }

    function getPartyCount() public returns (uint)
    {
        return partyCount;
    }

    function getNames(uint _id) public returns(uint,string memory)
    {
        require(_id<=partyCount);
        return (PartyStore[_id].voteCount,PartyStore[_id].name);
    }

    event IdentityCreate(string email, string birthdate, string gender, string affiliation, string state);
    event PartyCreate(string name, uint voteCount);
    event VoteGenerate(uint voteCount, uint time, string partyName, string adhaar, string constituency);
}