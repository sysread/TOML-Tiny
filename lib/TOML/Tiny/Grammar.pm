package TOML::Tiny::Grammar;
# ABSTRACT: exports regex definition of TOML grammar

use strict;
use warnings;
use v5.18;

use parent 'Exporter';

our @EXPORT = qw(
  $TOML
);

our $TOML = qr{

(?(DEFINE)
  #-----------------------------------------------------------------------------
  # Misc
  #-----------------------------------------------------------------------------
  (?<Value>
      (?&Boolean)
    | (?&DateTime)
    | (?&Float)
    | (?&Integer)
    | (?&String)
    | (?&Array)
    | (?&InlineTable)
  )

  (?<WS>   [ \x20 \x09 ]*)         # space, tab
  (?<CRLF> \x0D? \x0A)             # cr? lf
  (?<EOL>  (?: \x23 .*)? (?&CRLF)) # crlf or comment -> crlf

  #-----------------------------------------------------------------------------
  # Array of tables
  #-----------------------------------------------------------------------------
  (?<ArrayOfTables>
    (?m)
    (?s)

    \[\[ (?&Key) \]\] (?&EOL)

    (?:
        (?: (?&KeyValuePair) (?=(?&CRLF)) )
      | (?&ArrayOfTables)
      | (?&Table)
    )*

    (?-s)
    (?-m)
  )

  #-----------------------------------------------------------------------------
  # Table
  #-----------------------------------------------------------------------------
  (?<KeyValuePair> (?&Key) (?&WS) = (?&WS) (?&Value))
  (?<KeyValuePairDecl> (?&Key) (?&WS) = (?&WS) (?&Value) (?&WS) (?&EOL))

  (?<KeyValuePairList>
      (?&KeyValuePair) (?&WS) (?: [,] (?&WS) (?&KeyValuePairList) )?
    | (?&KeyValuePair)
  )

  (?<InlineTable>
    {
      (?&WS)
      (?&KeyValuePairList)
      (?&WS)
    }
  )

  (?<TableDecl> \[ (?&Key) \] (?&EOL))

  (?<Table>
    (?&TableDecl)
    (?:
        (?&KeyValuePairDecl)
      | (?&ArrayOfTables)
    )*
  )

  #-----------------------------------------------------------------------------
  # Array
  #-----------------------------------------------------------------------------
  (?<ListSep>
    (?&WS)
    [,]
    (?&WS)
    (?&CRLF)?
    (?&WS)
  )

  (?<List>
      (?&Value) (?&ListSep) (?&List)?
    | (?&Value)
  )

  (?<Array>
    \[

    (?&WS) (?&CRLF)? (?&WS)

    (?&List)

    (?&WS) (?&CRLF)? (?&WS)

    \]
  )

  #-----------------------------------------------------------------------------
  # Key
  #-----------------------------------------------------------------------------
  (?<BareKey>   (?> [-_a-zA-Z0-9]+ ))
  (?<QuotedKey> (?> (?&BasicString) | (?&StringLiteral)))
  (?<SimpleKey> (?> (?&BareKey) | (?&QuotedKey)))
  (?<DottedKey> (?> (?&SimpleKey) (?: \x2E (?&SimpleKey) )+))
  (?<Key>       (?&BareKey) | (?&QuotedKey) | (?&DottedKey))

  #-----------------------------------------------------------------------------
  # Boolean
  #-----------------------------------------------------------------------------
  (?<Boolean> (?: \b (?:true) | (?:false) \b ))

  #-----------------------------------------------------------------------------
  # Integer
  #-----------------------------------------------------------------------------
  (?<DecFirstChar>  [1-9])
  (?<DecChar>       [0-9])
  (?<HexChar>       [0-9 a-f A-F])
  (?<OctChar>       [0-7])
  (?<BinChar>       [01])

  (?<Zero> [-+]? 0)
  (?<Hex> 0x (?&HexChar) (?> _? (?&HexChar) )*)
  (?<Oct> 0o (?&OctChar) (?> _? (?&OctChar) )*)
  (?<Bin> 0b (?&BinChar) (?> _? (?&BinChar) )*)
  (?<Dec>
      (?&Zero)
    | (?> [-+]? (?&DecFirstChar) (?> _?  (?&DecChar) )* )
  )

  (?<Integer>
    (?>
        (?&Hex)
      | (?&Oct)
      | (?&Bin)
      | (?&Dec)
    )
  )

  #-----------------------------------------------------------------------------
  # Float
  #-----------------------------------------------------------------------------
  (?<Exponent>      [eE] (?&Dec))
  (?<SpecialFloat>  [-+]? (?> (?:inf) | (?:nan)))
  (?<Fraction>      [.] (?&DecChar) (?> _? (?&DecChar) )* )

  (?<Float>
    (?>
      (?&Dec)

      (?>
          (?> (?&Fraction) (?&Exponent)? )
        | (?&Exponent)
      )
    )
    | (?&SpecialFloat)
  )

  #-----------------------------------------------------------------------------
  # String
  #-----------------------------------------------------------------------------
  (?<EscapeChar>
    \x5C                        # leading \
    (?>
        [\x5C"btnfr]            # escapes: \\ \" \b \t \n \f \r
      | (?> u [_0-9a-fA-F]{4} ) # unicode (4 bytes)
      | (?> U [_0-9a-fA-F]{8} ) # unicode (8 bytes)
    )
  )

  (?<StringLiteral>
    (?> ' [^']* ')            # single quoted string (no escaped chars allowed)
  )

  (?<MultiLineStringLiteral>
    (?>
      '''                     # opening triple-quote
      (?>
          [^']
        | '{1,2}
      )*?
      '''                     # closing triple-quote
    )
  )

  (?<BasicString>
    (?>
      "                       # opening quote
      (?>                     # escape sequences or any char except " or \
          [^"\\]
        | (?&EscapeChar)
      )*
      "                       # closing quote
    )
  )

  (?<MultiLineString>
    """                       # opening triple-quote
    (?>
        [^"\\]
      | "{1,2}                # 1-2 quotation marks
      | (?&EscapeChar)        # escape
      | (?: \\ (?&CRLF))     # backslash-terminated line
    )*?
    """                       # closing triple-quote
  )

  (?<String>
      (?&MultiLineString)     # multi-line first or first two chars match empty basic string
    | (?&BasicString)
    | (?&MultiLineStringLiteral) 
    | (?&StringLiteral)
  )

  #-----------------------------------------------------------------------------
  # Dates (RFC 3339)
  #   1985-04-12T23:20:50.52Z
  #-----------------------------------------------------------------------------
  (?<Date>        \d{4}-\d{2}-\d{2} )
  (?<Offset>      (?: [-+] \d{2}:\d{2} ) | Z )
  (?<SimpleTime>  \d{2}:\d{2}:\d{2} (?: \. \d+ )? )
  (?<Time>        (?&SimpleTime) (?&Offset)? )
  (?<DateTime>    (?> (?&Date) (?> [T ] (?&Time) )? ) | (?&Time) )
)

}x;

1;

=head1 SYNOPSIS

  use TOML::Tiny::Grammar;

  if ($src =~ /(?&MultiLineString) $TOML/x) {
    ...
  }

=head1 DESCRIPTION

Exports C<$TOML>, a regex grammar for parsing TOML source.

=head1 RULES

=head2 (?&WS)
=head2 (?&EOL)

=head2 (?&Value)
=head3 (?&Boolean)
=head3 (?&DateTime)
=head3 (?&Float)
=head3 (?&Integer)
=head3 (?&String)
=head3 (?&Array)
=head3 (?&InlineTable)

=head2 (?&Key)
=head3 (?&BareKey)
=head3 (?&QuotedKey)
=head3 (?&DottedKey)

=head2 (?&ArrayOfTables)
=head2 (?&KeyValuePair)
=head2 (?&KeyValuePairDecl)
=head2 (?&TableDecl)
=head2 (?&Table)
=head2 (?&Array)

=cut
