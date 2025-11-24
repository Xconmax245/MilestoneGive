# Audit Specification — MilestoneGive (Updated)

This file lists invariants, threat model, and auditor tasks. Use this as the handoff to auditors.

## High-level invariants
1. **Single Escrow Source**: For each campaign, campaign.escrow contains the sole AptosCoin balance for that campaign. Withdrawals and refunds must update both on-chain coin balance and accounting fields.
2. **Release Policy**: Funds are only released by `release_funds_internal` after milestone verified (vote quorum + majority).
3. **Refund Policy**: Refunds can only be requested after milestone deadline passes and the milestone is unverified; refunds are full from the donor's allocated amount for that milestone.
4. **No Double Spend**: After release, funding_allocated for the milestone must be zeroed; donors already refunded cannot be refunded again.

## Threat Model and checks
- **Timestamp manipulation**: `now_seconds()` relies on Aptos timestamp; ensure the chain's timestamp cannot be manipulated by validators in ways that allow premature close_vote or refunds. Auditor should recommend mitigation or off-chain secondary checks if necessary.
- **Access Control**: Admin-only functions must be verified. Admin is the deployer address. Auditor should confirm no privileged function can be called by others.
- **Sybil / Vote Spam**: Voting is 1 address = 1 vote; platform must consider off-chain verification or token-weighting to mitigate Sybil attacks. Auditor should highlight the risk and mitigation options (e.g., weighted voting, stake-based voting, or identity checks).
- **Coin Handling**: Verify all coin::withdraw / deposit sequences have no gaps that could lead to coin loss. Ensure coin::withdraw errors are handled.
- **Integer Safety**: Use u128 for extremely large amounts if needed. Auditor should check for over/underflow possibilities.
- **Denial of Service**: Ensure vector growth operations won't allow malicious users to force out-of-gas or state bloat — recommend off-chain pagination and limits.
- **Event Auditability**: Events are emitted for all critical state transitions. Auditor should verify events are emitted reliably.

## Test & verification targets
- Unit tests for: create_campaign, donate, create_vote, cast_vote, close_vote, release_funds_internal, request_refund, freeze/unfreeze/pause/unpause.
- Property tests to assert invariants under random sequences of operations.
- Formal verification on: release_funds_internal, request_refund, and vote-close logic.

## Deliverables for auditor
- The Move package with complete unit tests.
- A short threat-model write-up describing attacker goals and mitigations.
- A test plan with scenario list (e.g., mass-donations, partial release, refund after partial release).
- Suggested runtime config: per-campaign cap, per-transaction coin cap, vote max duration, max voters processed.

## Operational recommendations
- Use a hardware wallet or HSM for admin/deployer keys.
- Staged rollout: testnet → small-cap mainnet → larger mainnet.
- Bug bounty program (start with $10K–$50K depending on budget).
