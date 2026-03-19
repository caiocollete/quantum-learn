import Std.Convert.*;
import Std.Math.*;

operation Main() : Unit {
    let max = 100;
    let min = 30;
    Message($"Generating a random number between 0 and {max}: ");

    // Generate random number in the 0..max range.
    let randomNum = GenerateRandomNumberInRange(max);
    Message($"Generated random number: {randomNum}");

    let randomNumInRange = GenerateRandomNumberInRangeMin(min, max);
    Message($"Generated random number between {min} and {max}: {randomNumInRange}");

    Message("Done :)");
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
    let sample = ResultArrayAsInt(bits);
    if(sample < max){
        return sample;
    }
    else{
        // If the sample is greater than max, we need to resample
        return GenerateRandomNumberInRange(max);
    }
}

operation GenerateRandomNumberInRangeMin(min : Int, max : Int) : Int {
    mutable bits = [];
    let nBits = BitSizeI(max);
    for idxBit in 1..nBits{
        set bits += [GenerateRandomBit()];
    }
    let sample = ResultArrayAsInt(bits);

    if(sample != 0 and sample > min and sample < max){
        return sample;
    }
    else{
        // If the sample is outside the range, we need to resample
        return GenerateRandomNumberInRangeMin(min, max);
    }
}