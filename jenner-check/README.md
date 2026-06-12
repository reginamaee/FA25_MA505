# Jenner compatibility tests

This directory was added by a pull request from the
[Jenner](https://jenneranalytics.com) project. Each `tNNN_*` subdirectory is
one of your MA-505 class examples, adapted to run on its own through the
Jenner API — a SAS-compatible engine with support for 200+ procedures.

## What's in here

```
jenner-check/
├── README.md          # this file
├── run_jenner.sh      # mac/linux runner (curl-based)
├── run_jenner.bat     # windows runner
├── run_jenner.sas     # SAS-side helper
└── t001_…/
    ├── script.sas     # the SAS script, adapted from your repo
    ├── autoexec.sas   # rebuilds any datasets the script needs (inline)
    ├── expected.json  # the fields pinned from a passing run
    ├── expected/      # a snapshot of what Jenner produced (log/listing/files)
    └── meta.json      # which file in your repo it came from
```

Each bundle is self-contained: `autoexec.sas` recreates the data the example
needs with inline `datalines`, so there are no external files to fetch.

## How to run it

From inside this `jenner-check/` directory:

```bash
./run_jenner.sh --list                 # list the bundles
./run_jenner.sh t003_nov13_pdv_retain  # run one bundle
./run_jenner.sh --all                  # run all of them
```

The runner concatenates each bundle's `autoexec.sas` and `script.sas`, posts
them to `https://api.jenneranalytics.com/v1/run`, and prints the status,
exit code, and the first lines of the log. On Windows, use `run_jenner.bat`
or run `run_jenner.sh` under WSL.

You can also paste any `script.sas` (with its `autoexec.sas` on top) straight
into the hosted workspace at [jenneranalytics.com](https://jenneranalytics.com).

## Don't want future PRs from us?

Reply to this PR with `no-more-prs` (case-insensitive) anywhere in a comment,
or open an issue titled `jenner-check: opt out`, and we'll stop.

## About this project

Jenner is a SAS-compatible engine; full context is at
[jenneranalytics.com](https://jenneranalytics.com). It's available for Mac on
the Apple App Store, and by license for Windows and Linux.
