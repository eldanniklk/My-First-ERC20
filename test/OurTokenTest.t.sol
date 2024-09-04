// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test } from "forge-std/Test.sol";
import {DeployOurToken } from "../script/DeployOurToken.s.sol";
import {OurToken } from "../src/OurToken.sol";
interface MintableToken {
    function mint(address, uint256) external;
}
contract OurTokenTest is Test {

    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 1000 ether;


    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {

        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }
    function testAllowancesWorks() public {
        uint256 initialAllowance = 1000;
        //bob aproves alice  to spend tokens on her behalf
    vm.prank(bob);
    ourToken.approve(alice, initialAllowance);
    uint256 transferAmount= 500; 
    vm.prank(alice);
    ourToken.transferFrom(bob, alice, transferAmount);

    assertEq(ourToken.balanceOf(alice), transferAmount);
    assertEq(ourToken.balanceOf(bob),STARTING_BALANCE - transferAmount);

    }

    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testTransfer() public {
        vm.prank(bob);
        ourToken.transfer(bob,STARTING_BALANCE );
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testTransferFrom() public {
        uint256 amount = 1000;
        vm.prank(bob);
    ourToken.approve(alice, amount);
    uint256 transferAmount= 500; 
    vm.prank(alice);
    ourToken.transferFrom(bob, alice, transferAmount);

    assertEq(ourToken.balanceOf(alice), transferAmount);
    assertEq(ourToken.balanceOf(bob),STARTING_BALANCE - transferAmount);
    }

    function testAllowance() public {
        vm.prank(bob);
        ourToken.approve(alice,STARTING_BALANCE );
        assertEq (ourToken.allowance(bob, alice), STARTING_BALANCE);
    }

  
}