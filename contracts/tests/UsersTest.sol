pragma solidity >=0.4.21 <0.7.0;

import "remix_tests.sol"; // this import is automatically injected by Remix.
import "../contracts/Users.sol";

contract UsersTest {
    Users users;

    function beforeAll () public {
        users = new Users();
    }

    function registerUsers() public {
        Assert.equal(users.register("test1@site.com", "password123"), true, "test1@site.com should be able to register.");
        Assert.equal(users.register("test1@site.com", "password123"), false, "test1@site.com should not be able to register twice.");
        Assert.equal(users.register("test2@site.com", "456Password"), true, "test2@site.com should be able to register.");
    }

    function loginUsers() public {
        Assert.equal(users.login("test1@site.com", "wrongPassword"), false, "test1@site.com should not be able to login with a wrong password.");
        Assert.equal(users.login("test1@site.com", "password123"), true, "test1@site.com should be able to login with the correct password.");
        Assert.equal(users.login("test2@site.com", "456password"), false, "test2@site.com should not be able to login with a wrong password due to case sensitivity.");
        Assert.equal(users.login("test2@site.com", "456Password"), true, "test2@site.com should be able to login with the correct password.");
    }
}
