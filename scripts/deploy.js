const main = async () => {
    const nftContractFactory = hre.ethers.getContractFactory('MembershipNFT');
    const nftContract = nftContractFactory.deploy();
    await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}