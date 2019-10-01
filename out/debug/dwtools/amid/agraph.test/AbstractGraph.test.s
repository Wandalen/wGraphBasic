( function _AbstractGraph_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../../Tools.s' );

  _.include( 'wTesting' );

  require( '../graphBasic/IncludeTop.s' );

}

var _ = wTools;

// --
// context
// --

function dag6()
{
  let context = this;
  var length = 5;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }

/*

    a → b → e → f
    ↓   ↓
    c ← d

    d
*/

  a.nodes.push( b, c );
  b.nodes.push( d, e );
  c.nodes.push();
  d.nodes.push( c );
  e.nodes.push( f );
  f.nodes.push();

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled1Scc()
{
  let context = this;
  var length = 3;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }

/*

    a ↔ b
    ↓
    c

*/

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push();

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled2Scc()
{
  let context = this;
  var length = 5;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

/*

    a ↔ b
    ↓   ↑
    c ↔ e

    d
*/

  a.nodes.push( b, c );
  b.nodes.push( a );
  // c.nodes.push( a, e );
  c.nodes.push( e );
  d.nodes.push();
  e.nodes.push( c, b );

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled3Scc()
{
  let context = this;
  var length = 8;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }
  var h = { name : 'h', nodes : [] }

/*

    a 🡘 b
    🡙
    c 🡘 d

    e

    f
    🡙
    g 🡘 h

*/

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled4Scc()
{
  let context = this;
  var length = 10;
  var a = { name : 'a', nodes : [] } /* 1 */
  var b = { name : 'b', nodes : [] } /* 2 */
  var c = { name : 'c', nodes : [] } /* 3 */
  var d = { name : 'd', nodes : [] } /* 4 */
  var e = { name : 'e', nodes : [] } /* 5 */
  var f = { name : 'f', nodes : [] } /* 6 */
  var g = { name : 'g', nodes : [] } /* 7 */
  var h = { name : 'h', nodes : [] } /* 8 */
  var i = { name : 'i', nodes : [] } /* 9 */
  var j = { name : 'j', nodes : [] } /* 10 */

/*

   ---- e → c
  |     ↓ ↖ ↓
  | d → a → b
  | ↓       ↓
  | g       f
  |  ↘      ↑
   - → h ⇄  i

    j

*/

  a.nodes.push( b );        /*  1  */
  b.nodes.push( e, f );     /*  2  */
  c.nodes.push( b );        /*  3  */
  d.nodes.push( a, g );     /*  4  */
  e.nodes.push( a, c, h );  /*  5  */
  f.nodes.push();           /*  6  */
  g.nodes.push( h );        /*  7  */
  h.nodes.push( i );        /*  8  */
  i.nodes.push( f, h );     /*  9  */
  j.nodes.push();           /*  10 */

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h, i, j ];
  gr.connectedNodes = [ a, b, c, d, e, f, g, h, i ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycledGamma()
{
  let context = this;
  var length = 6;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }

/*

        ↷
        f
        ↑
    a → d → e
    ↓ ↖ ↓
  ↪ b → c
    ↓
    d

*/

  a.nodes.push( b, d );
  b.nodes.push( c, d, b );
  c.nodes.push( a );
  d.nodes.push( c, e, f );
  e.nodes.push();
  f.nodes.push( f );

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycledAsymetricZeta()
{
  let context = this;
  var length = 8;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }
  var h = { name : 'h', nodes : [] }

/*

    a → b
      ↖ ↓
        c
        ↓
        d
        ↓
        e
        ↓
        f
      ↗ ↓
    h ← g
*/

  a.nodes.push( b );
  b.nodes.push( c );
  c.nodes.push( a, d );
  d.nodes.push( e );
  e.nodes.push( f );
  f.nodes.push( g );
  g.nodes.push( h );
  h.nodes.push( f );

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h ];
  gr.nodes.forEach( ( e ) => g[ e.name ] = e );

  return gr;
}

//

function cycledAsymetricChi()
{
  let context = this;
  var length = 13;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }
  var h = { name : 'h', nodes : [] }
  var i = { name : 'i', nodes : [] }
  var j = { name : 'j', nodes : [] }
  var k = { name : 'k', nodes : [] }
  var l = { name : 'l', nodes : [] }
  var m = { name : 'm', nodes : [] }

/*

    a ↔ b        e ↔ d
        ↓        ↓
        c        f
        ↓        ↓
             g
          🡗    🡖
        h        k
        ↓        ↓
  ↪ j ↔ i        l ↔ m ↩

*/

  a.nodes.push( b );
  b.nodes.push( a, c );
  c.nodes.push( g );
  d.nodes.push( e );
  e.nodes.push( f, d );
  f.nodes.push( g );

  g.nodes.push( h, k );

  h.nodes.push( i );
  i.nodes.push( j );
  j.nodes.push( i, j );
  k.nodes.push( l );
  l.nodes.push( m );
  m.nodes.push( m, l );

  let gr = { length }
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h, i, j, k, l, m ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

// --
// tests
// --

function makeByNodes( test )
{
  let context = this;

  test.case = 'init, add, delete, finit';

  var gr = context.cycled2Scc();

  var group = gr.sys.nodesGroup();
  test.identical( group.nodes.toArray().original, [] );

  test.identical( group.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  group.nodesAdd( gr.nodes );

  test.identical( group.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.a ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodeDelete( gr.d );
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 4 );
  test.identical( gr.sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 1, 2, 3, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  gr.sys.finit();

  /* */

  test.case = 'nodesDelete';

  var gr = context.cycled2Scc();
  var group = gr.sys.nodesGroup();

  test.identical( group.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  group.nodesAdd( gr.nodes );

  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodesDelete([ gr.a, gr.d, gr.e ]);
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 2 );
  test.identical( gr.sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 2, 3 ] );
  logger.log( group.infoExport() );

  group.nodesDelete();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  gr.sys.finit();

}

//

function makeByNodesWithInts( test )
{
  let context = this;

  test.case = 'init, add, delete, finit';

  var gr = {};
  function onNodeNameGet( node ){ return node };
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : onNodeNameGet });
  var group = gr.sys.nodesGroup();

  group.onOutNodesGet = function onOutNodesGet( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+gr.outNodes.length );
    let result = gr.outNodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  test.is( gr.sys === group.sys );
  test.identical( gr.sys.groups.length, 1 );

  gr.a = 11;
  gr.b = 12;
  gr.c = 13;
  gr.d = 14;
  gr.e = 15;
  gr.nodes = [ gr.a, gr.b, gr.c, gr.d, gr.e ];

  gr.outNodes = [];
  gr.outNodes[ 0 ] = [ gr.b, gr.c ];
  gr.outNodes[ 1 ] = [ gr.a ];
  gr.outNodes[ 2 ] = [ gr.a, gr.e ];
  gr.outNodes[ 3 ] = [];
  gr.outNodes[ 4 ] = [ gr.c ];

  test.identical( group.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  // group.nodesAdd([ a, b, c, d, e ]);
  group.nodesAdd( gr.nodes );

  test.identical( group.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.a ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodeDelete( gr.d );
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 4 );
  test.identical( gr.sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  gr.sys.finit();

  /* */

  test.case = 'nodesDelete';

  var gr = {};
  function onNodeNameGet( node ){ return node };
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : onNodeNameGet });
  var group = gr.sys.nodesGroup();

  test.is( gr.sys.onNodeNameGet === onNodeNameGet );
  test.is( group.onNodeNameGet === onNodeNameGet );

  group.onOutNodesGet = function onOutNodesGet( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+gr.outNodes.length );
    let result = gr.outNodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  test.is( gr.sys === group.sys );
  test.identical( gr.sys.groups.length, 1 );

  gr.a = 11;
  gr.b = 12;
  gr.c = 13;
  gr.d = 14;
  gr.e = 15;
  gr.nodes = [ gr.a, gr.b, gr.c, gr.d, gr.e ];

  gr.outNodes = [];
  gr.outNodes[ 0 ] = [ gr.b, gr.c ];
  gr.outNodes[ 1 ] = [ gr.a ];
  gr.outNodes[ 2 ] = [ gr.a, gr.e ];
  gr.outNodes[ 3 ] = [];
  gr.outNodes[ 4 ] = [ gr.c ];

  test.identical( group.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  group.nodesAdd( gr.nodes );

  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodesDelete([ gr.a, gr.d, gr.e ]);
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 2 );
  test.identical( gr.sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 2, 3 ] );
  logger.log( group.infoExport() );

  group.nodesDelete();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  gr.sys.finit();

}

//

function clone( test )
{
  let context = this;

  test.case = 'trivial';

  // var a = { name : 'a', nodes : [] }
  // var b = { name : 'b', nodes : [] }
  // var c = { name : 'c', nodes : [] }
  // var d = { name : 'd', nodes : [] }
  // var e = { name : 'e', nodes : [] }
  //
  // a.nodes.push( gr.b, gr.c );
  // b.nodes.push( gr.a );
  // c.nodes.push( gr.a, gr.e );
  // e.nodes.push( gr.c );

  // var gr.sys = new _.graph.AbstractGraphSystem();
  var gr = context.cycled2Scc();
  var group = gr.sys.nodesGroup();
  // group.nodesAdd([ a, b, c, d, e ]);
  group.nodesAdd( gr.nodes );
  var group2 = group.clone();

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( gr.sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( gr.sys.groups.length, 1 );

  group2.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );

  gr.sys.finit();

  /* */

  test.case = 'node delete';

  // var a = { name : 'a', nodes : [] }
  // var b = { name : 'b', nodes : [] }
  // var c = { name : 'c', nodes : [] }
  // var d = { name : 'd', nodes : [] }
  // var e = { name : 'e', nodes : [] }
  //
  // a.nodes.push( gr.b, gr.c );
  // b.nodes.push( gr.a );
  // c.nodes.push( gr.a, gr.e );
  // e.nodes.push( gr.c );
  //
  // var gr.sys = new _.graph.AbstractGraphSystem
  // ({
  //   onNodeNameGet : _.graph.AbstractNodesGroup.prototype.nodeNameFromFieldName
  // });

  var gr = context.cycled2Scc();
  var group = gr.sys.nodesGroup();
  // group.nodesAdd([ a, b, c, d, e ]);
  group.nodesAdd( gr.nodes );
  var group2 = group.clone();

  group.nodeDelete( gr.a );
  group2.nodeDelete( gr.b );

  test.identical( group.hasNode( gr.a ), false );
  test.identical( group.hasNode( gr.b ), true );
  test.identical( group2.hasNode( gr.a ), true );
  test.identical( group2.hasNode( gr.b ), false );
  test.identical( gr.sys.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.b ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( gr.sys.idToNodeHash.size, 5 );
  test.identical( gr.sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 4 );
  test.identical( group2.nodes.length, 4 );
  test.identical( gr.sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group2.nodeDelete( gr.a )
  group.nodeDelete( gr.b );

  test.identical( group.hasNode( gr.a ), false );
  test.identical( group.hasNode( gr.b ), false );
  test.identical( group2.hasNode( gr.a ), false );
  test.identical( group2.hasNode( gr.b ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.b ), false );

  test.identical( gr.sys.nodeDescriptorsHash.size, 3 );
  test.identical( gr.sys.idToNodeHash.size, 3 );
  test.identical( gr.sys.nodeToIdHash.size, 3 );
  test.identical( group.nodes.length, 3 );
  test.identical( group2.nodes.length, 3 );
  test.identical( gr.sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 3 );
  test.identical( gr.sys.idToNodeHash.size, 3 );
  test.identical( gr.sys.nodeToIdHash.size, 3 );
  test.identical( gr.sys.groups.length, 1 );

  group2.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );

  gr.sys.finit();

}

//

function reverse( test )
{
  let context = this;

  /* */

  test.case = 'cycled 1 scc';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  var group2 = group.clone();

  group2.cacheInNodesFromOutNodesOnce();
  group2.infoExport();
  group2.reverse();

  var exp =
`a : b
b : a
c : a`
  test.identical( group2.infoExport(), exp );

  var exp =
`a : b c
b : a
c : `
  test.identical( group.infoExport(), exp );

  gr.sys.finit();

  /* */

  test.case = 'cycled 4 scc';
  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  var group2 = group.clone();

  var exp =
`a : b
b : e f
c : b
d : a g
e : a c h
f :
g : h
h : i
i : f h
j :`
  test.equivalent( group2.infoExport(), exp );
  var exp =
`a : b
b : e f
c : b
d : a g
e : a c h
f :
g : h
h : i
i : f h
j :`
  test.equivalent( group.infoExport(), exp );

  group2.cacheInNodesFromOutNodesOnce();
  group2.infoExport();
  group2.reverse();
  group2.infoExport();

  var exp =
`a : b
b : e f
c : b
d : a g
e : a c h
f :
g : h
h : i
i : f h
j :`
  test.equivalent( group.infoExport(), exp );

  var exp =
`a : d e
b : a c
c : e
d :
e : b
f : b i
g : d
h : e g i
i : h
j : `
  test.equivalent( group2.infoExport(), exp );

  test.identical( gr.sys.nodeDescriptorsHash.size, 10 );
  test.identical( gr.sys.idToNodeHash.size, 10 );
  test.identical( gr.sys.nodeToIdHash.size, 10 );
  test.identical( group.nodes.length, 10 );
  test.identical( group2.nodes.length, 10 );
  test.identical( gr.sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] );

  var expected =
  [
    [ 'b' ],
    [ 'e', 'f' ],
    [ 'b' ],
    [ 'a', 'g' ],
    [ 'a', 'c', 'h' ],
    [],
    [ 'h' ],
    [ 'i' ],
    [ 'f', 'h' ],
    []
  ]
  var outNodes = group.nodesOutNodesFor( group.nodes ).map( ( nodes ) => group.nodesToNames( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );

  var expected =
  [
    [ 'd', 'e' ],
    [ 'a', 'c' ],
    [ 'e' ],
    [],
    [ 'b' ],
    [ 'b', 'i' ],
    [ 'd' ],
    [ 'e', 'g', 'i' ],
    [ 'h' ],
    []
  ]
  var outNodes = group2.nodesOutNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToNames( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );
  var expected =
  [
    [ 'b' ],
    [ 'e', 'f' ],
    [ 'b' ],
    [ 'a', 'g' ],
    [ 'a', 'c', 'h' ],
    [],
    [ 'h' ],
    [ 'i' ],
    [ 'f', 'h' ],
    []
  ]
  var outNodes = group2.nodesInNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToNames( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );

  group2.reverse();
  test.identical( gr.sys.nodeDescriptorsHash.size, 10 );
  test.identical( gr.sys.idToNodeHash.size, 10 );
  test.identical( gr.sys.nodeToIdHash.size, 10 );
  test.identical( group.nodes.length, 10 );
  test.identical( group2.nodes.length, 10 );
  test.identical( gr.sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 10 );
  test.identical( gr.sys.idToNodeHash.size, 10 );
  test.identical( gr.sys.nodeToIdHash.size, 10 );
  test.identical( gr.sys.groups.length, 1 );

  group2.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.idToNodeHash.size, 0 );
  test.identical( gr.sys.nodeToIdHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );

  gr.sys.finit();

  /* */

}

//

function nodesAs( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a' ];
  var dst = gr.a;
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );

  test.case = '[ a ]';
  var exp = [ 'a' ];
  var dst = [ gr.a ];
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b' ];
  var dst = [ gr.a, gr.b ];
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a' ];
  var dst = gr.a;
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );

  test.case = '[ a ]';
  var exp = new Set([ 'a' ]);
  var dst = new Set([ gr.a ]);
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.setIs( got ) );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.setIs( got ) );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function sourcesFromRoots( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'all';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var got = group.sourcesFromRoots( null, gr.nodes );
  debugger;
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  debugger;

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.c ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsAllReachable( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.c ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.b ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsAll( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.c ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.b ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}


//

function sinksOnlyAmong( test )
{
  let context = this;

  test.case = 'cycled4';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'explicit';
  var got = group.sinksOnlyAmong( gr.nodes );
  var expected = [ 'f', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  test.case = 'implicit';
  group.nodesAdd( gr.nodes );
  var got = group.sinksOnlyAmong();
  var expected = new Set([ 'f', 'j' ]);
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  gr.sys.finit();
}

//

function sourcesOnlyAmong( test )
{
  let context = this;

  test.description = 'setup';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  group.nodesAdd( gr.nodes );
  var got = group.sourcesOnlyAmong();
  var expected = new Set([ 'd', 'j' ]);
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  gr.sys.finit();
}

//

function leastMostDegreeAmong( test )
{
  let context = this;

  test.case = 'cycled4';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );

  var got = group.leastIndegreeAmong();
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong();
  var expected = new Set([ 'd', 'j' ]);
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostIndegreeAmong();
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong();
  var expected = new Set([ 'h' ]);
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.leastOutdegreeAmong();
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong();
  var expected = new Set([ 'f', 'j' ]);
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostOutdegreeAmong();
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong();
  var expected = new Set([ 'e' ]);
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  test.case = 'no least indegree';

  var got = group.leastIndegreeAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = 1;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'c', 'e', 'g', 'i' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostIndegreeAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'h' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.leastOutdegreeAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'f' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostOutdegreeAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'e' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  test.case = 'no most indegree';

  var got = group.leastIndegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = [ 'd', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostIndegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = 2;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = [ 'a', 'b', 'f' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.leastOutdegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = [ 'f', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostOutdegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.i, gr.j ]);
  var expected = [ 'e' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  test.case = 'no leasr outdegree';

  var got = group.leastIndegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = [ 'd' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostIndegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = [ 'h' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.leastOutdegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = 1;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = [ 'a', 'c', 'g', 'h' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostOutdegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  var expected = [ 'e' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  test.case = 'no most outdegree';

  var got = group.leastIndegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = [ 'd', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostIndegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = [ 'h' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.leastOutdegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = [ 'f', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostOutdegreeAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = 2;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ gr.a, gr.b, gr.c, gr.d, gr.f, gr.g, gr.h, gr.i, gr.j ]);
  var expected = [ 'b', 'd', 'i' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  gr.sys.finit();
}

//

function lookBfs( test )
{
  let context = this;

  var nds = [];
  var ups = [];
  var dws = [];
  var lups = [];
  var ldws = [];

  function clean()
  {
    nds = [];
    ups = [];
    dws = [];
    lups = [];
    ldws = [];
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

/*
  1 : 2
  2 : 6
  3 : 2
  4 : 1 7
  5 : 1 3 8
  6 :
  7 : 8
  8 : 9
  9 : 6 8
  10 :
*/

  test.description = 'setup';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  /* */

  test.case = 'all';

  clean();
  var layers = group.lookBfs({ roots : group.nodes, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = _.setsFrom([ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ] ]);
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedUps = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedDws = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedLups = _.setsFrom
  ([
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
    [ 'b', 'e', 'f', 'b', 'a', 'g', 'a', 'c', 'h', 'h', 'i', 'f', 'h' ],
  ]);
  var expectedLdws = _.setsFrom
  ([
    [],
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
  ]);

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only a';

  clean();
  var layers = group.lookBfs({ roots : gr.a, onNode, onUp, onDown, onLayerUp, onLayerDown }); debugger;

  var expected = _.setsFrom([ [ 'a' ], [ 'b' ], [ 'e', 'f' ], [ 'c', 'h' ], [ 'i' ] ]);
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedUps = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedDws = [ 'i', 'c', 'h', 'e', 'f', 'b', 'a' ];
  var expectedLups = _.setsFrom
  ([
    [ 'a' ],
    [ 'b' ],
    [ 'e', 'f' ],
    [ 'a', 'c', 'h' ],
    [ 'b', 'i' ],
    [ 'f', 'h' ]
  ]);
  var expectedLdws = _.setsFrom
  ([
    [],
    [ 'i' ],
    [ 'c', 'h' ],
    [ 'e', 'f' ],
    [ 'b' ],
    [ 'a' ]
  ]);

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only d';

  clean();
  var layers = group.lookBfs({ roots : gr.d, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = _.setsFrom
  ([
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ])
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'c', 'e', 'f', 'i', 'b', 'h', 'a', 'g', 'd' ];
  var expectedLups = _.setsFrom
  ([
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'a', 'c', 'h', 'f', 'h' ],
    [ 'b' ]
  ])
  var expectedLdws = _.setsFrom
  ([
    [],
    [ 'c' ],
    [ 'e', 'f', 'i' ],
    [ 'b', 'h' ],
    [ 'a', 'g' ],
    [ 'd' ]
  ])

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'd and a -- array';

  clean();
  var layers = group.lookBfs({ roots : [ gr.d, gr.a ], onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = _.setsFrom
  ([
    [ 'd', 'a' ],
    [ 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'c' ]
  ])
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'i', 'c', 'h', 'e', 'f', 'g', 'b', 'd', 'a' ];
  var expectedLups = _.setsFrom
  ([
    [ 'd', 'a' ],
    [ 'a', 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'a', 'c', 'h' ],
    [ 'f', 'h', 'b' ]
  ])
  var expectedLdws = _.setsFrom
  ([
    [],
    [ 'i', 'c' ],
    [ 'h', 'e', 'f' ],
    [ 'g', 'b' ],
    [ 'd', 'a' ]
  ])

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  gr.sys.finit();

} /* end of lookBfs */

//

function lookBfsRevisiting( test )
{
  let context = this;

  var nds = [];
  var ups = [];
  var dws = [];
  var lups = [];
  var ldws = [];

  function clean()
  {
    nds = [];
    ups = [];
    dws = [];
    lups = [];
    ldws = [];
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  function onUp( node, it )
  {
    if( it.level > 4 )
    it.continueUp = 0;
    ups.push( group.nodesToNames( node ) );
  }

  function onUp2( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    debugger;
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp2( nodes, it )
  {
    debugger;
    if( it.level > 4 )
    it.continueUp = 0;
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerDown( nodes, it )
  {
    debugger;
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  // var gr = context.cycled3Scc();
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];

    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ],
      [ 'b', 'd', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'a', 'e', 'f' ],
      [ 'c', 'd' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups = _.setsFrom
    ([
      [ 'e' ],
      []
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'e' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'f' ];
    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    var expectedLups = _.setsFrom
    ([
      [ 'f' ],
      [ 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'f' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 0' );

    test.open( 'revisiting : 1' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];

    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ],
      [ 'b', 'd', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'a', 'e', 'f' ],
      [ 'c', 'd' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups = _.setsFrom
    ([
      [ 'e' ],
      []
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'e' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'f' ];
    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    var expectedLups = _.setsFrom
    ([
      [ 'f' ],
      [ 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'f' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 1' );

    test.open( 'revisiting : 2' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    // var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f' ];
    // var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f' ];
    // var expectedDws = [ 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];
    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'f' ];
    var expectedDws = [ 'a', 'f', 'c', 'd', 'b', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'f' ];
    var expectedDws = [ 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b' ];

    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ],
      [ 'b', 'd', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'a', 'e', 'f' ],
      [ 'c', 'd' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups = _.setsFrom
    ([
      [ 'e' ],
      []
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'e' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'f', 'f' ];
    var expectedUps = [ 'f', 'f' ];
    var expectedDws = [ 'f', 'f' ];

    var expectedLups = _.setsFrom
    ([
      [ 'f' ],
      [ 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'f' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 2' );

    test.open( 'revisiting : 3' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    // var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    // var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    // var expectedDws = [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];
    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedDws = [ 'c', 'd', 'b', 'e', 'f', 'a', 'b', 'd', 'a', 'f', 'c', 'e', 'a', 'c', 'e', 'f', 'd', 'b', 'c', 'd', 'b', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    // var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    // var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    // var expectedDws = [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'b' ];
    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'd', 'b', 'c', 'd', 'b', 'e', 'f', 'a', 'b', 'd', 'a', 'f', 'c', 'e', 'a', 'c', 'e', 'f', 'd', 'b', 'c', 'd', 'b', 'b' ];

    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups = _.setsFrom
    ([
      [ 'e' ],
      []
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'e' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f' ];

    var expectedLups = _.setsFrom
    ([
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ])


    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 3' );

    test.open( 'revisiting : 3, with onLayerUp' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    // var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    // var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    // var expectedDws = [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];
    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedDws = [ 'c', 'd', 'b', 'e', 'f', 'a', 'b', 'd', 'a', 'f', 'c', 'e', 'a', 'c', 'e', 'f', 'd', 'b', 'c', 'd', 'b', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    // var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    // var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    // var expectedDws = [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'b' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'd', 'b', 'c', 'd', 'b', 'e', 'f', 'a', 'b', 'd', 'a', 'f', 'c', 'e', 'a', 'c', 'e', 'f', 'd', 'b', 'c', 'd', 'b', 'b' ];

    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.e,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups = _.setsFrom
    ([
      [ 'e' ],
      []
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'e' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      roots : gr.f,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f' ];

    var expectedLups = _.setsFrom
    ([
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 3, with onLayerUp' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookBfsRevisiting */

//

function lookBfsExcluding( test )
{
  let context = this;

  var nds = [];
  var ups = [];
  var dws = [];
  var lups = [];
  var ldws = [];

  function clean()
  {
    nds = [];
    ups = [];
    dws = [];
    lups = [];
    ldws = [];
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  function onUp( node, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( group.nodesToNames( node ) );
  }

  function onUp2( node, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( group.nodesToNames( node ) );
  }

  function onDown2( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    debugger;
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp3( nodes, it )
  {
    debugger;
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp4( nodes, it )
  {
    debugger;
    if( it.level > 0 )
    it.continueUp = 0;
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerDown3( nodes, it )
  {
    if( it.continueNode )
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  // var gr = context.cycled3Scc();
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding elements';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, excluding elements';

    clean();
    group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'c', 'd' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only a, not visiting elements';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp : onUp2,
      onDown : onDown2,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, not visiting elements';

    clean();
    group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp : onUp2,
      onDown : onDown2,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only a, excluding layers';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp3,
      onLayerDown : onLayerDown3,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
    ])
    var expectedLdws = _.setsFrom
    ([
      [ 'b', 'd' ],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, excluding layers';

    clean();
    group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp3,
      onLayerDown : onLayerDown3,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ],
    ])
    var expectedLdws = _.setsFrom
    ([
      [ 'c', 'd' ],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only a, not visiting layers';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp4,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups = _.setsFrom
    ([
      [ 'a' ],
      [ 'b', 'd' ],
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'a' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, not visiting layers';

    clean();
    group.lookBfs
    ({
      roots : gr.b,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp4,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups = _.setsFrom
    ([
      [ 'b' ],
      [ 'c', 'd', 'b' ]
    ])
    var expectedLdws = _.setsFrom
    ([
      [],
      [ 'b' ]
    ])

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookBfsExcluding */

//

function lookDfs( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

/*
  1 : 2
  2 : 6
  3 : 2
  4 : 1 7
  5 : 1 3 8
  6 :
  7 : 8
  8 : 9
  9 : 6 8
  10 :
*/

  test.description = 'setup';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  test.case = 'all'; /* */

  clean();
  group.lookDfs({ roots : group.nodes, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  a  b  e  c  h  i  f  d  gr  j
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6, 4, 7, 10 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4, 10 ];
  //                  c  f  i  h  e  b  a  gr  d  j

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  test.case = 'only a'; /* */

  clean();
  group.lookDfs({ roots : gr.a, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  a  b  e  c  h  i  f
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1 ];
  //                  c  f  i  h  e  b  a

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  test.case = 'only d'; /* */

  clean();
  group.lookDfs({ roots : gr.d, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  d  a  b  e  c  h  i  f  gr
  var expectedUps = [ 4, 1, 2, 5, 3, 8, 9, 6, 7 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4 ];
  //                  c  f  i  h  e  b  a  gr  d

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  /* */

  gr.sys.finit();

} /* end of lookDfs */

//

function lookDfsRevisiting( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 7 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  // group.nodesAdd( gr.nodes );
  // group.nodesAdd([ a, b, c, d, e ]);
  // test.identical( group.nodes.length, 10 );
  // logger.log( group.infoExport() );

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
    var expectedDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
    var expectedDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 0' );
    test.open( 'revisiting : 1' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'c', 'd', 'c', 'e', 'f', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'c', 'e', 'f', 'd', 'b', 'c', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'd', 'e', 'f', 'd', 'c', 'a', 'e', 'f' ];
    var expectedDws = [ 'e', 'f', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'd', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 1' );

    test.open( 'revisiting : 2' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

 /* var expectedUps = [ 'a', 'b', 'c',      'd', 'c',      'e', 'f',           'd', 'c',      'e', 'f'      ]; */
    var expectedUps = [ 'a', 'b', 'c', 'a', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'd', 'c', 'a', 'e', 'f', 'f' ];
    var expectedDws = [ 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'b', 'd', 'c', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'b' ];
    var expectedDws = [ 'b', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f' ];
    var expectedDws = [ 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 2' );

    test.open( 'revisiting : 3' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ]
    var expectedDws = [ 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* - */

    test.close( 'revisiting : 3' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDfsRevisiting */

//

function lookDfsExcluding( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function handleUp2( nodeHandle, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function handleDown2( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  // var gr = context.cycled3Scc();
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, excluding';

    clean();
    group.lookDfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only a, not visiting';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, not visiting';

    clean();
    group.lookDfs
    ({
      roots : gr.b,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDfsExcluding */

//

function lookDbfsRevisiting( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 7 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  // var gr = context.cycled3Scc();
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  // group.nodesAdd([ a, b, c, d, e ]);
  // test.identical( group.nodes.length, 10 );
  // logger.log( group.infoExport() );

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 0' );

    test.open( 'revisiting : 1' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'c', 'e', 'f', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'c', 'e', 'f', 'd', 'b', 'c', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'a', 'd', 'e', 'f', 'c', 'e', 'f', 'a' ];
    var expectedDws = [ 'e', 'f', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'd', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 1' );

    test.open( 'revisiting : 2' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'f' ];
    var expectedDws = [ 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f' ];
    var expectedDws = [ 'b', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f' ];
    var expectedDws = [ 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 2' );

    test.open( 'revisiting : 3' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'a' ];
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      roots : gr.e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      roots : gr.f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* - */

    test.close( 'revisiting : 3' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDbfsRevisiting */

//

function lookDbfsExcluding( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function handleUp2( nodeHandle, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function handleDown2( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  // var gr = context.cycled3Scc();
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding';

    clean();
    group.lookDbfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, excluding';

    clean();
    group.lookDbfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only a, not visiting';

    clean();
    group.lookDbfs
    ({
      roots : gr.a,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, not visiting';

    clean();
    group.lookDbfs
    ({
      roots : gr.b,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDbfsExcluding */

//

function eachBfs( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  /* - */

  test.description = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  // var d = { name : 'd', nodes : [] } // 4
  // var e = { name : 'e', nodes : [] } // 5
  // var f = { name : 'f', nodes : [] } // 6
  //
  // a.nodes.push( gr.b, gr.d ); // 1
  // b.nodes.push( gr.c, gr.d, gr.d ); // 2
  // c.nodes.push( gr.a ); // 3
  // d.nodes.push( gr.c, gr.e, gr.e ); // 4
  // e.nodes.push(); // 5
  // f.nodes.push( gr.f ); // 6
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  // var gr = context.cycled3Scc();
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, withTerminals : 0, withStem : 0, mandatory : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, withTerminals : 0, withStem : 0, mandatory : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, e';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'c', 'a', 'd', 'f' ];
  var expUps = [ 'c', 'a', 'd', 'f' ];
  var expDws = [ 'c', 'a', 'd', 'f' ];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, withTerminals : 0, withStem : 0, mandatory : 1 });
    test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'mandatory : 1, f';
  clean();
  var exp = [];
  var expNds = [];
  var expUps = [];
  var expDws = [];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, withTerminals : 0, withStem : 0, mandatory : 1 });
    test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'recursive : 1, a';
  clean();
  var exp = [ 'a', 'b', 'd' ];
  var expNds = [ 'a', 'b', 'd' ];
  var expUps = [ 'a', 'b', 'd' ];
  var expDws = [ 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, b';
  clean();
  var exp = [ 'b', 'c', 'd' ];
  var expNds = [ 'b', 'c', 'd' ];
  var expUps = [ 'b', 'c', 'd' ];
  var expDws = [ 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, a';
  clean();
  var exp = [ 'a' ];
  var expNds = [ 'a' ];
  var expUps = [ 'a' ];
  var expDws = [ 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, b';
  clean();
  var exp = [ 'b' ];
  var expNds = [ 'b' ];
  var expUps = [ 'b' ];
  var expDws = [ 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachBfs */

//

function eachDfs( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  /* - */

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  /* */

  test.description = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, a';
  clean();
  var exp = [ 'a', 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, b';
  clean();
  var exp = [ 'b', 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, withTerminals : 0, withStem : 0, mandatory : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, withTerminals : 0, withStem : 0, mandatory : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, e';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'c', 'a', 'd', 'f' ];
  var expUps = [ 'c', 'a', 'd', 'f' ];
  var expDws = [ 'c', 'a', 'd', 'f' ];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, withTerminals : 0, withStem : 0, mandatory : 1 });
    test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'mandatory : 1, f';
  clean();
  var exp = [];
  var expNds = [];
  var expUps = [];
  var expDws = [];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, withTerminals : 0, withStem : 0, mandatory : 1 });
    test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'recursive : 1, a';
  clean();
  var exp = [ 'a', 'b', 'd' ];
  var expNds = [ 'a', 'b', 'd' ];
  var expUps = [ 'a', 'b', 'd' ];
  var expDws = [ 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, b';
  clean();
  var exp = [ 'b', 'c', 'd' ];
  var expNds = [ 'b', 'c', 'd' ];
  var expUps = [ 'b', 'c', 'd' ];
  var expDws = [ 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, a';
  clean();
  var exp = [ 'a' ];
  var expNds = [ 'a' ];
  var expUps = [ 'a' ];
  var expDws = [ 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, b';
  clean();
  var exp = [ 'b' ];
  var expNds = [ 'b' ];
  var expUps = [ 'b' ];
  var expDws = [ 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachDfs */

//

function eachDbfs( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  /* - */

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  /* */

  test.description = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, includingBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, withTerminals : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, withTerminals : 0, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, withTerminals : 0, withStem : 0, mandatory : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, withTerminals : 0, withStem : 0, mandatory : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, e';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'c', 'a', 'd', 'f' ];
  var expUps = [ 'c', 'a', 'd', 'f' ];
  var expDws = [ 'c', 'a', 'd', 'f' ];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, withTerminals : 0, withStem : 0, mandatory : 1 });
    test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'mandatory : 1, f';
  clean();
  var exp = [];
  var expNds = [];
  var expUps = [];
  var expDws = [];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, withTerminals : 0, withStem : 0, mandatory : 1 });
    test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'recursive : 1, a';
  clean();
  var exp = [ 'a', 'b', 'd' ];
  var expNds = [ 'a', 'b', 'd' ];
  var expUps = [ 'a', 'b', 'd' ];
  var expDws = [ 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, b';
  clean();
  var exp = [ 'b', 'c', 'd' ];
  var expNds = [ 'b', 'c', 'd' ];
  var expUps = [ 'b', 'c', 'd' ];
  var expDws = [ 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, recursive : 1 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, a';
  clean();
  var exp = [ 'a' ];
  var expNds = [ 'a' ];
  var expUps = [ 'a' ];
  var expDws = [ 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.a, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, b';
  clean();
  var exp = [ 'b' ];
  var expNds = [ 'b' ];
  var expUps = [ 'b' ];
  var expDws = [ 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.b, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.e, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : gr.f, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachDbfs */

//

function dagTopSortDfs( test )
{
  let context = this;

  test.case = 'trivial DAG';

  var gr = context.dag6();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( 'DAG' )
  logger.log( group.nodesInfoExport() );

  var ordering = group.dagTopSortDfs();
  logger.log( 'Ordering' )
  logger.log( group.nodesInfoExport( ordering ) );

  test.description = 'trivial';
  var expected = [ 3, 4, 6, 5, 2, 1 ];
  test.identical( group.nodesToIds( ordering ), expected );
  var expected = [ 'c', 'd', 'f', 'e', 'b', 'a' ];
  test.identical( group.nodesToNames( ordering ), expected );

  test.description = 'with help of all([ gr.d ])'
  var ordering = group.dagTopSortDfs( group.rootsAllReachable([ gr.d ]) );
  var expected = [ 'c', 'd' ];
  test.identical( group.nodesToNames( ordering ), expected );

  test.shouldThrowErrorSync( () =>
  {
    test.description = 'b';
    var ordering = group.dagTopSortDfs([ gr.b ]);
    var expected = [ 'c', 'd', 'f', 'e', 'b' ];
    test.identical( group.nodesToNames( ordering ), expected );
  });

  /* */

  test.case = 'cycled';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.shouldThrowErrorSync( () =>
  {
    test.description = 'with help of all([ gr.d ])'
    var ordering = group.dagTopSortDfs( [ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i, gr.j ] );
  });

  gr.sys.finit();
}

//

function topSortSourceBasedBfs( test )
{
  let context = this;

  test.case = 'cycled4Scc';

  var gr = context.cycled4Scc();

  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );
  group.finit();

  /* */

  test.description = 'all explicit';

  debugger;

  var group = gr.sys.nodesGroup();
  var layers = group.topSortSourceBasedBfs( gr.nodes );
  debugger;

  var expected = _.setsFrom
  ([
    [ 'd', 'j' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]);

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  group.finit();

  /* */

  test.description = 'not j';

  var group = gr.sys.nodesGroup();
  var layers = group.topSortSourceBasedBfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = _.setsFrom
  ([
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]);

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  group.finit();

  /* */

  test.description = 'not j, not d';

  var group = gr.sys.nodesGroup();
  group.cacheInNodesFromOutNodesOnce( gr.nodes );
  var layers = group.topSortSourceBasedBfs([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);

  var expected = _.setsFrom
  ([
    [ 'c', 'e', 'g', 'i' ],
    [ 'b', 'a', 'h', 'f' ]
  ]);

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  group.finit();

  /* */

  test.description = 'c, e - without adding nodes';

  test.shouldThrowErrorSync( () =>
  {
    var group = gr.sys.nodesGroup();
    group.nodesAdd( gr.nodes );
    var layers = group.topSortSourceBasedBfs([ gr.c, gr.e ]);
  });

  /* */

  test.description = 'c, e';

  var group = gr.sys.nodesGroup();
  group.cacheInNodesFromOutNodesOnce( gr.nodes );
  var layers = group.topSortSourceBasedBfs([ gr.c, gr.e ]);

  var expected = _.setsFrom
  ([
    [ 'c', 'e' ],
    [ 'b', 'a', 'h' ],
    [ 'f', 'i' ],
  ]);

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  group.finit();

  gr.sys.finit();

  /* */

  test.description = 'cycled1Scc';

  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );

  /* */

  test.description = 'implicit';
  var layers = group.topSortSourceBasedBfs();
  var expected = _.setsFrom
  ([
    [ 'a', 'b', 'c' ],
  ]);

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  gr.sys.finit();

}

//

function topSortCycledSourceBasedBfs( test )
{
  let context = this;

  /* - */

  test.case = 'trivial';

  // var a = { name : 'a', nodes : [] }
  // var b = { name : 'b', nodes : [] }
  // var c = { name : 'c', nodes : [] }
  //
  // a.nodes.push( gr.b, gr.c );
  // b.nodes.push( gr.a );
  // c.nodes.push();
  //
  // var gr.sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );

  /* */

  debugger;
  var layers = group.topSortCycledSourceBasedBfs();
  debugger;

  var expected =
  [
    [ 'a', 'b' ],
    [ 'c' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  gr.sys.finit();

  /* */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();
  var group = gr.sys.nodesGroup();

  test.description = 'all';
  var layers = group.topSortCycledSourceBasedBfs( gr.nodes );
  var expected = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  gr.sys.finit();

  /* */

  test.case = 'cycled asymetric chi';

  var gr = context.cycledAsymetricChi();
  var group = gr.sys.nodesGroup();

  test.description = 'all';
  var layers = group.topSortCycledSourceBasedBfs( gr.nodes );
  var expected = [ 'd', 'e', 'a', 'b', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  test.description = 'all a';
  debugger;
  var layers = group.topSortCycledSourceBasedBfs( group.rootsAllReachable( gr.a ) );
  debugger;
  var expected = [ 'e', 'd', 'a', 'b', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  gr.sys.finit();

  /* - */

  test.case = 'complex';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes ); // xxx
  logger.log( group.infoExport() );

  /* */

  test.description = 'all';

  debugger;
  var layers = group.topSortCycledSourceBasedBfs();
  debugger;

  var expected =
  [
    [ 'j', 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.description = 'not j';

  var layers = group.topSortCycledSourceBasedBfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i ]);

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.description = 'not j, not d';

  var layers = group.topSortCycledSourceBasedBfs([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.description = 'c, e';

  test.shouldThrowErrorSync( () => group.topSortCycledSourceBasedBfs([ gr.c, gr.e ]) );

  var expected = [];

  gr.sys.finit();

  /* - */
}

// --
// connectivity
// --

function pairDirectedPathGetDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple'; // xxx

  var gr = context.cycled3Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var exp = [ 'a' ];
  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.a ]);
  test.identical( group.nodesToNames( connected ), exp );

  var exp = [ 'b', 'a' ];
  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.b ]);
  test.identical( group.nodesToNames( connected ), exp );

  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.e ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.f ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  test.description = 'g';

  var exp = [ 'g' ];
  var connected = group.pairDirectedPathGetDfs([ gr.g, gr.g ]);
  test.identical( group.nodesToNames( connected ), exp );

  var exp = [ 'f', 'g' ];
  var connected = group.pairDirectedPathGetDfs([ gr.g, gr.f ]);
  test.identical( group.nodesToNames( connected ), exp );

  var connected = group.pairDirectedPathGetDfs([ gr.g, gr.b ]);
  test.identical( connected, false );

  var exp = [ 'g', 'f' ];
  var connected = group.pairDirectedPathGetDfs([ gr.f, gr.g ]);
  test.identical( group.nodesToNames( connected ), exp );

  var exp = [ 'f' ];
  var connected = group.pairDirectedPathGetDfs([ gr.f, gr.f ]);
  test.identical( group.nodesToNames( connected ), exp );

  var connected = group.pairDirectedPathGetDfs([ gr.f, gr.b ]);
  test.identical( connected, false );

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();
  var group = gr.sys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.h ]);
  test.identical( connected, false );

  test.description = 'h a';
  var exp = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  debugger;
  var connected = group.pairDirectedPathGetDfs([ gr.h, gr.a ]);
  test.identical( group.nodesToNames( connected ), exp );
  debugger;

  /* */

  gr.sys.finit();

}

//

function pairDirectedPathExistsDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var gr = context.cycled3Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.a ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.b ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.e ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.f ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  test.description = 'g';

  var connected = group.pairDirectedPathExistsDfs([ gr.g, gr.g ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ gr.g, gr.f ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ gr.g, gr.b ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ gr.f, gr.g ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ gr.f, gr.f ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ gr.f, gr.b ]);
  test.identical( connected, false );

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';

  var gr = context.cycledAsymetricZeta();
  var group = gr.sys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairDirectedPathExistsDfs([ gr.a, gr.h ]);
  test.identical( connected, false );

  test.description = 'h a';
  var connected = group.pairDirectedPathExistsDfs([ gr.h, gr.a ]);
  test.identical( connected, true );

  /* */

  gr.sys.finit();
}

//

function pairIsConnectedDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var gr = context.cycled3Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var connected = group.pairIsConnectedDfs([ gr.a, gr.a ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ gr.a, gr.b ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ gr.a, gr.e ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ gr.a, gr.f ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  test.description = 'g';

  var connected = group.pairIsConnectedDfs([ gr.g, gr.g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ gr.g, gr.f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ gr.g, gr.b ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ gr.f, gr.g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ gr.f, gr.f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ gr.f, gr.b ]);
  test.identical( connected, false );

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';

  var gr = context.cycledAsymetricZeta();
  var group = gsys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairIsConnectedDfs([ gr.a, gr.h ]);
  test.identical( connected, true );

  test.description = 'h a';
  var connected = group.pairIsConnectedDfs([ gr.h, gr.a ]);
  test.identical( connected, true );

  /* */

  gr.sys.finit();
}

//

function pairIsConnectedStronglyDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var gr = context.cycled3Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.a ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.b ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.e ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.f ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.g ]);
  test.identical( connected, false );

  test.description = 'g';

  var connected = group.pairIsConnectedStronglyDfs([ gr.g, gr.g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ gr.g, gr.f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ gr.g, gr.b ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ gr.f, gr.g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ gr.f, gr.f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ gr.f, gr.b ]);
  test.identical( connected, false );

  /* */

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();
  var group = gr.sys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairIsConnectedStronglyDfs([ gr.a, gr.h ]);
  test.identical( connected, true );

  test.description = 'h a';
  var connected = group.pairIsConnectedStronglyDfs([ gr.h, gr.a ]);
  test.identical( connected, false );

  /* */

  gr.sys.finit();
}

//

function nodesConnectedLayersDfs( test )
{
  let context = this;

  test.description = 'setup';

  var gr = context.cycled3Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.case = 'explicit';
  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  var layers = group.nodesConnectedLayersDfs( group.nodes );
  test.identical( layers.length, 3 );
  test.identical( layers, expected );

  test.case = 'implicit';
  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  var layers = group.nodesConnectedLayersDfs();
  test.identical( layers.length, 3 );
  test.identical( layers, expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();

  /* */

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  var layers = group.nodesConnectedLayersDfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h ]);
  var names = layers.map( ( ids ) => group.idsToNames( ids ) );
  var expected = [ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ] ]
  test.identical( names, expected );
  group.finit();

  /* */

  gr.sys.finit();

}

//

function nodesStronglyConnectedLayersDfs( test )
{
  let context = this;

  test.description = 'setup';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  var expected = [ [ j ], [ f ], [ i, h ], [ gr ], [ a, b, e, c ], [ d ] ];
  var groups = group.nodesStronglyConnectedLayersDfs( group.nodes );
  test.identical( groups, expected );

  var expectedIds =
  [
    [ 'j' ],
    [ 'f' ],
    [ 'i', 'h' ],
    [ 'g' ],
    [ 'a', 'b', 'e', 'c' ],
    [ 'd' ]
  ]
  var groupsIds = groups.map( ( nodes ) => group.nodesToNames( nodes ) );
  test.identical( groupsIds, expectedIds );

  gr.finit();
}

//

function nodesStronglyConnectedTreeDfs( test )
{
  let context = this;

  /* - */

  // test.case = 'trivial';
  // var gr = context.cycled1Scc();
  //
  // /* */
  //
  // var group = gr.sys.nodesGroup({});
  //
  // group.nodesAdd( gr.nodes );
  // logger.log( 'Original' );
  // logger.log( group.infoExport() );
  //
  // var group2 = group.nodesStronglyConnectedTreeDfs();
  // group2.onNodeNameGet = function onNodeNameGet( dnode )
  // {
  //   return group.nodesToNames( dnode.originalNodes ).join( '+' );
  // }
  // logger.log( 'Strongly connected tree :\n' + group2.infoExport() );
  // var originalNodesNames = group2.nodes.map( ( node ) => group.nodesToNames( node.originalNodes ).toArray().original ).toArray().original;
  // var expected = [ [ 'c' ], [ 'a', 'b' ] ];
  // test.identical( originalNodesNames, expected );
  //
  // var outNodes = group2.nodes.map( ( node ) => group2.nodesToIds( node.outNodes ).toArray().original ).toArray().original;
  // var expected = [ [], [ 4 ] ];
  // test.identical( outNodes, expected );
  //
  // var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  // var expected = [ 'c : ', 'a+b : c' ];
  // test.identical( outNodes, expected );
  //
  // /* */
  //
  // gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();

  /* */

  // test.description = 'all';
  // var group = gr.sys.nodesGroup();
  // var group2 = group.nodesStronglyConnectedTreeDfs( gr.nodes );
  // group2.onNodeNameGet = function onNodeNameGet( dnode )
  // {
  //   return group.nodesToNames( dnode.originalNodes ).join( '+' );
  // }
  // var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  // var expected = [ 'h+f+gr : ', 'e : h+f+gr', 'd : e', 'a+b+c : d' ];
  // test.identical( outNodes, expected );
  // group.finit();

  /* */

  test.description = '[ a, h, gr, f, e, d, c, b ]';
  var group = gr.sys.nodesGroup();
  debugger;
  var group2 = group.nodesStronglyConnectedTreeDfs([ gr.a, gr.h, gr.g, gr.f, gr.e, gr.d, gr.c, gr.b ]);
  debugger;
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'h+f+gr : ', 'e : h+f+gr', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  debugger; return; xxx

  /* */

  test.description = 'all a';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsAllReachable( gr.a ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+gr+h : ', 'e : f+gr+h', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all c';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsAllReachable( gr.c ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+gr+h : ', 'e : f+gr+h', 'd : e', 'c+a+b : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all d';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsAllReachable( gr.d ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+gr+h : ', 'e : f+gr+h', 'd : e' ];
  test.identical( outNodes, expected );

  gr.sys.finit();

  /* - */

  test.case = 'complex'
  var gr = context.cycled4Scc();

  /* */

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( 'Original' );
  logger.log( group.infoExport() );
  var group2 = group.nodesStronglyConnectedTreeDfs();
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'j : ', 'f : ', 'i+h : f', 'gr : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
  test.identical( outNodes, expected );
  logger.log( 'Tree' );
  logger.log( group2.infoExport() );

  /* */

  test.description = 'all, explicit';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( gr.nodes );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'j : ', 'f : ', 'i+h : f', 'gr : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
  test.identical( outNodes, expected );
  logger.log( 'Tree' );
  logger.log( group2.infoExport() );

  /* */

  test.description = 'connected';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( gr.connectedNodes );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f : ', 'i+h : f', 'gr : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
  test.identical( outNodes, expected );
  logger.log( 'Tree' );
  logger.log( group2.infoExport() );

  /* */

  test.description = 'no j, no f';
  var group = gr.sys.nodesGroup();
  test.shouldThrowErrorSync( () =>
  {
    var group2 = group.nodesStronglyConnectedTreeDfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  });

  /* */

  gr.sys.finit();

  /* - */

}

//

function nodesExportInfoTree( test )
{
  let context = this;

  test.case = '4 scl';
  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );

  logger.log( 'DAG' )
  logger.log( group.nodesInfoExport() );

  test.description = 'single a';
  var expected =
  `+-- a
     +-- b
       +-- e
       | +-- c
       | +-- h
       |   +-- i
       |     +-- f
       +-- f
  `
  var infoAsTree = group.nodesExportInfoTree([ gr.a ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.description = 'single b';
  var expected =
  `+-- b
     +-- e
     | +-- a
     | +-- c
     | +-- h
     |   +-- i
     |     +-- f
     +-- f
  `
  var infoAsTree = group.nodesExportInfoTree([ gr.b ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.description = 'multiple: a, b, c';
  var expected =
  `+-- a
     | +-- b
     |   +-- e
     |   | +-- c
     |   | +-- h
     |   |   +-- i
     |   |     +-- f
     |   +-- f
     |
     +-- b
     | +-- e
     | | +-- a
     | | +-- c
     | | +-- h
     | |   +-- i
     | |     +-- f
     | +-- f
     |
     +-- c
       +-- b
         +-- e
         | +-- a
         | +-- h
         |   +-- i
         |     +-- f
         +-- f
  `
  var infoAsTree = group.nodesExportInfoTree([ gr.a, gr.b, gr.c ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.description = 'multiple, rootsDelimiting : 0';
  var expected =
  `+-- a
   | +-- b
   |   +-- e
   |   | +-- c
   |   | +-- h
   |   |   +-- i
   |   |     +-- f
   |   +-- f
   +-- b
   | +-- e
   | | +-- a
   | | +-- c
   | | +-- h
   | |   +-- i
   | |     +-- f
   | +-- f
   +-- c
     +-- b
       +-- e
       | +-- a
       | +-- h
       |   +-- i
       |     +-- f
       +-- f
  `
  var infoAsTree = group.nodesExportInfoTree( [ a, b, c ], { rootsDelimiting : 0 } );
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  // xxx
  // test.case = 'multiple + sourcesOnlyAmong';
  // var expected =
  // `+-- a
  //  | +-- b
  //  |   +-- e
  //  |   | +-- c
  //  |   | +-- h
  //  |   |   +-- i
  //  |   |     +-- f
  //  |   +-- f
  // `
  // debugger;
  // var nodes0 = group.rootsAllReachable([ gr.a, gr.b, gr.c ]);
  // debugger;
  // var nodes1 = group.dagTopSort( group.rootsAllReachable([ gr.a, gr.b, gr.c ]) );
  // debugger;
  // var nodes2 = group.topSortCycledSourceBased( group.rootsAllReachable([ gr.a, gr.b, gr.c ]) );
  // debugger;
  // var nodes3 = group.sourcesOnlyAmong( group.rootsAllReachable([ gr.a, gr.b, gr.c ]) );
  // debugger;
  // var infoAsTree = group.nodesExportInfoTree( group.sourcesOnlyAmong( group.rootsAllReachable([ gr.a, gr.b, gr.c ]) ) );
  // debugger;
  // test.equivalent( infoAsTree, expected );
  // logger.log( 'Tree' );
  // logger.log( infoAsTree );

} /* end of function nodesExportInfoTree */

// --
// declare
// --

var Self =
{

  name : 'Tools.mid.AbstractGraph',
  silencing : 1,

  context :
  {
    dag6,
    cycled1Scc,
    cycled2Scc,
    cycled3Scc,
    cycled4Scc,
    cycledGamma,
    cycledAsymetricZeta,
    cycledAsymetricChi,
  },

  tests :
  {

    makeByNodes,
    makeByNodesWithInts,
    clone,
    reverse,

    nodesAs,
    sourcesFromRoots,
    rootsAllReachable,
    rootsAll,

    sinksOnlyAmong,
    sourcesOnlyAmong,
    leastMostDegreeAmong,

    lookBfs,
    lookBfsRevisiting,
    lookBfsExcluding,

    lookDfs,
    lookDfsRevisiting,
    lookDfsExcluding,

    lookDbfsRevisiting,
    lookDbfsExcluding,

    eachBfs,
    eachDfs,
    eachDbfs,

    dagTopSortDfs,
    topSortSourceBasedBfs,
    topSortCycledSourceBasedBfs,

    // connectivity

    pairDirectedPathGetDfs,
    pairDirectedPathExistsDfs,
    pairIsConnectedDfs,
    pairIsConnectedStronglyDfs,

    nodesConnectedLayersDfs,
    nodesStronglyConnectedLayersDfs,
    nodesStronglyConnectedTreeDfs,

    nodesExportInfoTree,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
