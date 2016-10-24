# Notes

## Thinks I'd like to revisit/improve

There is a bit of disjointed behaviour between BankOCR and BankOCR.Parser.  The parser works primarily in strings passed to it. Since the parent module works primarily in lists, it's causing several places to require a join instruction.  It feels like it would be better to determine one form that would work for both and refactor to get to that point.

## Where to next

Obviously, still need to finish the remaining user cases.
Before that, however, I'd like to create the escript setup to use as a binary launcher.

Follwoing that

* create some tests with some valid and some invalid account numbers.
* Create a checksum valdiating module to perform the logic
* Hook it into parse_acct_numbers_in_file() and add routings in stringify to capture hte results

At that point, I can see some refactoring that might be needed.

* parse_acct_numbers_in_file feels like it will be badly named at that point, since it does more than parsing
* Seems likely at this point, that my {:valid, acct} tuple might have been a premature optimization
