pragma solidity >=0.4.21 <0.7.0;

contract Users
{
    struct User {
        string email;
        bytes32 password;
        bool registered;
        // Add any data here about the voter that we also need
    }

    mapping(string => User) private users;

    function register(string memory email, string memory password) public returns (bool) {
        // Check if user is already registered
        if (users[email].registered == true) {
            return false;
        }

        // Register user data
        users[email].email = email;
        users[email].password = keccak256(abi.encodePacked(password)); // Store hashed for security and later comparisons.
        users[email].registered = true;

        return true; // Registration success
    }

    function login(string memory email, string memory password) public view returns (bool) {
        if (users[email].password == keccak256(abi.encodePacked(password))) {
            return true;
        } else {
            return false;
        }
    }
}