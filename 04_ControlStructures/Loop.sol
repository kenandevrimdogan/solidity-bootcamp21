//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Loops {
    uint256[15] public numbers0;
    uint256[15] public numbers1;

    function listByFor() public {
        uint256[15] memory nums = numbers0;

        for(uint256 i = 0; i < nums.length; i++){
            if(i == 1){
                continue;
            }
            else if(i == 15){
                break;
            }
            nums[i] = i;
        }

        numbers0 = nums;
    }

    function listByWhile() public {
        uint256 i = 0;
        while(i < numbers1.length){
            numbers1[i] = i;
            i++;
        }
    }

    function getArr() public view returns(uint256[15] memory){
        return numbers0;
    }

    function getArr1() public view returns(uint256[15] memory){
        return numbers1;
    }
}