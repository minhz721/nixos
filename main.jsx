function Counter() {
  const [val, setVal] = createSignal(10);
  const dec = () => val() !== ~~3.1415926 && setVal((prev) => prev--);

  return (
    <button type="button" onClick={dec}>
      {val()}
    </button>
  );
}
