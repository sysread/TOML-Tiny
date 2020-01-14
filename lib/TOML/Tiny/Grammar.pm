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

  (?<NLSeq> (?> \x0D? \x0A))
  (?<NL> (?&NLSeq) | (?&Comment))

  (?<WSChar> \x20 | \x09)       # (space, tab)
  (?<WS> (?&WSChar)*)

  (?<Comment> \x23 .* (?&NLSeq)?)

  #-----------------------------------------------------------------------------
  # Array of tables
  #-----------------------------------------------------------------------------
  (?<ArrayOfTables>
    (?m)
    (?s)

    \[\[ (?&Key) \]\] \n
    (?:
        (?: (?&KeyValuePair) (?=(?&NLSeq)) )
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
  (?<KeyValuePairDecl> (?&Key) (?&WS) = (?&WS) (?&Value) (?&WS) (?&NL))

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

  (?<TableDecl>
    \[ (?&Key) \] \n
  )

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
    (?&NLSeq)?
    (?&WS)
  )

  (?<List>
      (?&Value) (?&ListSep) (?&List)?
    | (?&Value)
  )

  (?<Array>
    \[

    (?&WS) (?&NLSeq)? (?&WS)

    (?&List)

    (?&WS) (?&NLSeq)? (?&WS)

    \]
  )

  #-----------------------------------------------------------------------------
  # Key
  #-----------------------------------------------------------------------------
  (?<BareKey> [-_a-zA-Z0-9]+)
  (?<QuotedKey> (?&BasicString) | (?&StringLiteral))
  (?<DottedKey>
    (?: (?&BareKey) | (?&QuotedKey) )
    (?: (?&WS) [.] (?&WS) (?: (?&BareKey) | (?&QuotedKey) ) )+
  )
  (?<Key> (?&DottedKey) | (?&BareKey) | (?&QuotedKey) )

  #-----------------------------------------------------------------------------
  # Boolean
  #-----------------------------------------------------------------------------
  (?<Boolean> \b(?:true)|(?:false)\b)

  #-----------------------------------------------------------------------------
  # Integer
  #-----------------------------------------------------------------------------
  (?<DecFirstChar> [1-9])
  (?<DecChar> [0-9])
  (?<HexChar> [0-9 a-f A-F])
  (?<OctChar> [0-7])
  (?<BinChar> [01])

  (?<Zero> [-+]? 0)
  (?<Dec> (?&Zero) | (?: [-+]? (?&DecFirstChar) (?: (?&DecChar) | (?: _ (?&DecChar) ))*))
  (?<Hex> 0x (?&HexChar) (?: (?&HexChar) | (?: [_] (?&HexChar) ))*)
  (?<Oct> 0o (?&OctChar) (?: (?&OctChar) | (?: [_] (?&OctChar) ))*)
  (?<Bin> 0b (?&BinChar) (?: (?&BinChar) | (?: [_] (?&BinChar) ))*)

  (?<Integer> (?&Hex) | (?&Oct) | (?&Bin) | (?&Dec))

  #-----------------------------------------------------------------------------
  # Float
  #-----------------------------------------------------------------------------
  (?<Exponent> [eE] (?&Dec))
  (?<SpecialFloat> [-+]?  (?:inf) | (?:nan))
  (?<Fraction> [.] (?&Dec) )

  (?<Float>
    (?:
        (?: (?&Dec) (?&Fraction) (?&Exponent) )
      | (?: (?&Dec) (?&Exponent) )
      | (?: (?&Dec) (?&Fraction) )
    )
    |
    (?&SpecialFloat)
  )

  #-----------------------------------------------------------------------------
  # String
  #-----------------------------------------------------------------------------
  (?<EscapeChar>
    \x5C                        # leading \
    (?:
        [\x5C"btnfr]            # escapes: \\ \b \t \n \f \r
      | (?: u [_0-9a-fA-F]{4} ) # unicode (4 bytes)
      | (?: U [_0-9a-fA-F]{8} ) # unicode (8 bytes)
    )
  )

  (?<StringLiteral>
    (?: ' [^']* ')            # single quoted string (no escaped chars allowed)
  )

  (?<MultiLineStringLiteral>
    (?m)
    (?s)
    '''                       # opening triple-quote
    .*?
    '''                       # closing triple-quote
    (?-s)
    (?-m)
  )

  (?<BasicString>
    (?:
      "                       # opening quote
      (?:                     # escape sequences or any char except " or \
          (?: (?&EscapeChar) )
        | [^"\\]
      )*
      "                       # closing quote
    )
  )

  (?<MultiLineString>
    (?s)
    """                       # opening triple-quote
    (?:
      (?: (?&EscapeChar) )    # escaped char
      | .
    )*?
    """                       # closing triple-quote
    (?-s)
  )

  (?<String>
      (?&MultiLineString)
    | (?&BasicString)
    | (?&MultiLineStringLiteral)
    | (?&StringLiteral)
  )

  #-----------------------------------------------------------------------------
  # Dates (RFC 3339)
  #   1985-04-12T23:20:50.52Z
  #-----------------------------------------------------------------------------
  (?<Date> \d{4}-\d{2}-\d{2})

  (?<Offset>
      (?: [-+] \d{2}:\d{2} )
    | [Z]
  )

  (?<SimpleTime>
    \d{2}:\d{2}:\d{2}
    (?: [.] \d+ )?
  )

  (?<Time>
    (?&SimpleTime)
    (?&Offset)?
  )

  (?<DateTime>
      (?: (?&Date) [T ] (?&Time) )
    | (?&Date)
    | (?&Time)
  )
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
=head2 (?&NL)
=head2 (?&Comment)

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
