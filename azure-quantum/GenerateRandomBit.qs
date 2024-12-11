import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Math.*;

operation Main() : Int {
    let min = 50;
    let max = 100;
    Message($"Sampling a random number between 0 and {max}: ");
    Message($"Sampling a random number between {min} and {max}: ");

    // Generate random number in the 0..max range.
    return GenerateRandomNumberInRange(min, max);
}

/// Generates a random number between 0 and `max`.
operation GenerateRandomNumberInRange(min : Int, max : Int) : Int {
    // Validate input
    if (min > max) {
        fail $"Invalid range: min ({min}) cannot be greater than max ({max})";
    }
    // Determine the number of bits needed to represent `max` and store it
    // in the `nBits` variable. Then generate `nBits` random bits which will
    // represent the generated random number.
    mutable bits = [];
    // Determine the number of bits needed to represent the range
    let nBits = BitSizeI(max - min);
    for idxBit in 1..nBits {
        set bits += [GenerateRandomBit()];
    }
    let sample = ResultArrayAsInt(bits) + min;

    // Return random number if it is within the requested range.
    // Generate it again if it is outside the range.
    return sample > max ? GenerateRandomNumberInRange(min, max) | sample;
}

operation GenerateRandomBit() : Result {
    // Allocate a qubit.
    use q = Qubit();

    // Set the qubit into superposition of 0 and 1 using the Hadamard operation
    H(q);

    // Measure the qubit value using the `M` operation, and store the
    // measurement value in the `result` variable.
    let result = M(q);

    // Reset qubit to the |0〉 state.
    Reset(q);

    // Return the result of the measurement.
    return result;
}