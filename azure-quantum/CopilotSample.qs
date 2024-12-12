open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Measurement;

@EntryPoint()
operation MeasureAndResetQubit() : Result {
    use q = Qubit();
    H(q); // Coloca o qubit em superposição
    let result = MResetZ(q); // Mede e redefine o qubit
    return result;
}