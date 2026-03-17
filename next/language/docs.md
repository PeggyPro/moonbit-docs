# Comments and Documentation

## Comments

Use `//` for ordinary comments inside code:

```moonbit
// Explain why this branch exists.
let retries = 3
```

You will also often see `///|` at the start of top-level blocks. It is an
empty doc-comment line used to split top-level items explicitly. This matters
for documentation tooling today, and it also preserves clear top-level block
boundaries for future caching and other tooling purposes. In practice, `///|`
is useful in ordinary MoonBit code as well as in documentation sources.

## Doc Comments

Doc comments use `///` on each line immediately before a top-level item such as
`fn`, `let`, `enum`, `struct`, or `type`. Doc comments are written in
Markdown.

```{literalinclude} /sources/language/src/misc/top.mbt
:language: moonbit
:start-after: start doc string 1
:end-before: end doc string 1

```

Markdown code blocks inside doc comments marked with `mbt check` are treated as
document tests. `moon check` and `moon test` will automatically check and run
these tests, so that examples in doc comments are always up-to-date.
Wrap the snippet in `test { .. }` when you want a test block:

```{literalinclude} /sources/language/src/misc/top.mbt
:language: moonbit
:start-after: start doc test 1
:end-before: end doc test 1
```

If you want to prevent a code snippet from being treated as a document test,
mark it with a language id other than `mbt check` on the markdown code block:

```{literalinclude} /sources/language/src/misc/top.mbt
:language: moonbit
:start-after: start doc test 2
:end-before: end doc test 2
```

Currently, document tests are always [blackbox tests](/language/tests.md#blackbox-tests-and-whitebox-tests).
So private definitions cannot have document test.

## Literate `.mbt.md` Files

MoonBit also supports literate Markdown files ending in `.mbt.md`. These files
can live inside a package as checked documentation, or they can be used as
standalone single-file inputs to `moon check` and `moon test`.

For a standalone file, run:

```bash
moon check README.mbt.md
moon test README.mbt.md
```

Inside a project, keep using the package-level `moon check` and `moon test`
commands instead.

The code fence language controls how each block is handled:

- `mbt`: MoonBit code that is compiled, but does not create a test entry.
- `mbt check`: MoonBit document-test code. Use `test { .. }` or `async test`
  inside the block when you want assertions.
- `mbt nocheck`: Show MoonBit code without compiling or testing it.
- `moonbit`: Ordinary displayed code block for documentation; it is not
  compiled or tested.

For example:

```{literalinclude} /sources/language/src/misc/literate.mbt.md
:language: markdown
:start-after: <!-- start literate fences 1 -->
:end-before: <!-- end literate fences 1 -->
```

Standalone `.mbt.md` files can also declare front matter to specify imports or
the target backend:

```{literalinclude} /sources/single-file/README.mbt.md
:language: markdown
```

Use `moonbit.import` when you want to name the packages the file can import
directly. Use `moonbit.deps` when you only want to declare module dependencies
and let Moon synthesize the imports automatically.
