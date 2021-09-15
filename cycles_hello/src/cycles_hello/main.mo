import Nat64 "mo:base/Nat64";
import Cycles "mo:base/ExperimentalCycles";

shared(msg) actor class HelloCycles (capacity: Nat) {
    var balance = 0;

    public shared(msg) func wallet_balance(): async Nat {
        return balance;
    };

    public func wallet_receive(): async { accepted: Nat64 } {
        let amount = Cycles.available();
        let limit: Nat = capacity - balance;
        let accepted = if (amount <= limit) amount else limit;
        let deposit = Cycles.accept(accepted);
        assert (deposit == accepted);
        balance += accepted;
        return {accepted = Nat64.fromNat(accepted)};
    };

    public func greet(name: Text): async Text {
        return "Hello, " # name # "!";
    };

    public shared(msg) func owner(): async Principal {
        let currentOwner = msg.caller;
        return currentOwner;
    };
}