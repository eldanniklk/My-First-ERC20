// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { OurToken } from "../src/OurToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployOurToken is Script {
    uint256 public constant INITIAL_SUPPLY = 10000000000000 ether;
    function run () external returns(OurToken) {
        vm.startBroadcast();
        OurToken ot = new OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ot;
    }

}