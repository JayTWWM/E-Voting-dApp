pragma solidity >=0.4.21 <0.7.0;

// Facilitates registration of new users with an email and password.
// Stores the password as a secured byte hash.
// Allows for login verification by providing an email and password to check
// against the stored user database on the blockchain.

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
        if (exists(email)) {
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

    function exists(string memory email) public view returns (bool) {
        return users[email].registered;
    }
}