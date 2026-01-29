import { describe, it, expect } from 'vitest';
import { Cl } from '@stacks/transactions';

describe('Faucet Contract', () => {
  const accounts = simnet.getAccounts();
  const deployer = accounts.get('deployer')!;
  const wallet1 = accounts.get('wallet_1')!;

  it('should return drip amount', () => {
    const result = simnet.callReadOnlyFn('faucet', 'get-drip-amount', [], deployer);
    expect(result.result).toEqual(Cl.uint(1000000));
  });

  it('should check if user can claim', () => {
    const result = simnet.callReadOnlyFn('faucet', 'can-claim', [Cl.principal(wallet1)], wallet1);
    expect(result.result).toEqual(Cl.bool(false)); // No balance in faucet initially
  });

  it('should return cooldown blocks', () => {
    const result = simnet.callReadOnlyFn('faucet', 'get-cooldown', [], deployer);
    expect(result.result).toEqual(Cl.uint(144));
  });
});
