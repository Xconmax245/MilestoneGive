# MilestoneGive Move Package (Production — updated)

This package contains the Move smart contract and supporting files for the MilestoneGive platform.

## Quickstart
1. Install Aptos CLI and Move toolchain (see Aptos docs).
2. Place files in a directory with the `Move.toml` provided.
3. Compile:
4. Run tests (note: tests are scaffolds and may need adapting to your local harness):
5. Publish to testnet (use your profile / keys):

## Important Notes (must read before testnet/mainnet)
- The contract now uses Aptos on-chain time via `0x1::timestamp::now_seconds()` — ensure your network provides accurate timestamps.
- `CreatorKyc` is implemented as an on-chain registry inside the Store. Admin must call `set_creator_kyc(admin, creator_address, true)` to enable creators to launch campaigns.
- Event handles are centralized in Store and emitted for all actions (donation, vote, vote-cast, milestone verified, funds released, refund issued).
- BEFORE mainnet:
  - Expand unit tests into runnable Move tests for your environment.
  - Run property-based tests and invariants.
  - Conduct formal verification and a 3rd-party security audit.
  - Store deployer private key securely (HSM/hardware wallet), do not publish it in repos.

## Next actions I can perform for you:
- Convert test scaffolds into fully runnable Move tests for your target test harness.
- Add role-based multisig flows if required.
- Produce frontend JS / React example to interact with the deployed contract.
