// Test file for oxfmt Tailwind CSS ordering issue
// https://github.com/oxc-project/oxc/issues/18749

export function Example() {
  return (
    <div>
      {/* Test case 1: Original from issue */}
      <p className="font-normal text-pretty break-words">
        This should have consistent ordering across platforms
      </p>

      {/* Test case 2: More classes */}
      <div className="flex items-center justify-between gap-4 px-4 py-2">Content</div>

      {/* Test case 3: Using clsx function */}
      <button
        className={clsx("rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700")}
      >
        Button
      </button>

      {/* Test case 4: Using cn function */}
      <span
        className={cn(
          "text-sm leading-none font-medium peer-disabled:cursor-not-allowed peer-disabled:opacity-70",
        )}
      >
        Label
      </span>
    </div>
  );
}
