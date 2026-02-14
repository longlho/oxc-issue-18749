// Test file for oxfmt Tailwind CSS ordering issue
// https://github.com/oxc-project/oxc/issues/18749

export function Example() {
  return (
    <div>
      {/* Test case 1: Original from issue */}
      <p className="text-pretty break-words font-normal">
        This should have consistent ordering across platforms
      </p>

      {/* Test case 2: More classes */}
      <div className="flex items-center justify-between gap-4 px-4 py-2">
        Content
      </div>

      {/* Test case 3: Using clsx function */}
      <button className={clsx("bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded")}>
        Button
      </button>

      {/* Test case 4: Using cn function */}
      <span className={cn("text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70")}>
        Label
      </span>
    </div>
  );
}
