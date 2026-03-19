import Std.Convert.*;
import Std.Math.*;

operation Main() : Int {
    let max = 100;
    Message($"Generating a random number between 0 and {max}: ");

    // Generate random number in the 0..max range.
    return GenerateRandomNumberInRange(max);
}

operation GenerateRandomBit() : Result {

    // Create a qubit
    use q = Qubit();
    // Put the qubit in superposition
    H(q);
    // Keep the qubit position in a variable
    let result = M(q);
    // Reset the qubit to the |0⟩ state before releasing it
    Reset(q);

    return result;
}

operation GenerateRandomNumberInRange(max : Int) : Int {

    mutable bits = [];
    let nBits = BitSizeI(max);
    for idxBit in 1..nBits{
        set bits += [GenerateRandomBit()];
    }
}