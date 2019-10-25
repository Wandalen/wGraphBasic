( function _AbstractGraph_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../../Tools.s' );

  _.include( 'wTesting' );

  require( '../graphBasic/IncludeTop.s' );

}

var _ = _global_.wTools;

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
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

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

  ↪ a ↔ b        e ↔ d
        ↓        ↓
        c        f
        ↓        ↓
             g
          🡗    🡖
        h        k
        ↓        ↓
  ↪ j ↔ i        l ↔ m

*/

  a.nodes.push( a, b );
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
  m.nodes.push( l );

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

function sourcesFromNodes( test )
{
  let context = this;

  /* - */

  test.open( 'array, cycled4Scc' );

  var gr = context.cycled4Scc();

  test.case = 'all';
  var group = gr.sys.nodesGroup();
  var exp = [ 'j', 'd' ];
  var got = group.sourcesFromNodes( null, gr.nodes );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  test.case = 'but set( d, g, j )';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.b, gr.c, gr.e, gr.f, gr.h, gr.i ]; /* d, g, j */
  var got = group.sourcesFromNodes( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  gr.sys.finit();

  test.close( 'array, cycled4Scc' );

  /* - */

  test.open( 'set, cycled4Scc' );

  var gr = context.cycled4Scc();

  test.case = 'all';
  var group = gr.sys.nodesGroup();
  var exp = _.setFrom([ 'j', 'd' ]);
  var got = group.sourcesFromNodes( null, _.setFrom( gr.nodes ) );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  test.case = 'but set( d, g, j )';
  var group = gr.sys.nodesGroup();
  var exp = _.setFrom([ 'a', 'b', 'e', 'c' ]);
  var dst = _.setFrom([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.h, gr.i ]); /* d, g, j */
  var got = group.sourcesFromNodes( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  gr.sys.finit();

  test.close( 'set, cycled4Scc' );

  /* - */

  test.open( 'array, cycledGamma' );

  var gr = context.cycledGamma();

  test.case = 'all';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'c', 'd' ];
  var got = group.sourcesFromNodes( null, gr.nodes );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  test.case = 'f';
  var group = gr.sys.nodesGroup();
  var exp = [ 'f' ];
  var dst = [ gr.f ];
  var got = group.sourcesFromNodes( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  gr.sys.finit();

  test.close( 'array, cycledGamma' );

  /* - */

  test.open( 'array, cycled1Scc' );

  var gr = context.cycled1Scc();

  test.case = 'all';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b' ];
  var got = group.sourcesFromNodes( null, gr.nodes );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  test.case = 'c';
  var group = gr.sys.nodesGroup();
  var exp = [ 'c' ];
  var dst = [ gr.c ];
  var got = group.sourcesFromNodes( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  gr.sys.finit();

  test.close( 'array, cycled1Scc' );

  /* - */


} /* end of function sourcesFromNodes */

//

function sourcesFromRoots( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();

  test.case = 'all';
  var group = gr.sys.nodesGroup();
  var exp = [ 'j', 'd' ];
  var got = group.sourcesFromRoots( null, gr.nodes );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  test.case = 'a';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = gr.a;
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  test.case = '[ a ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );
  group.finit();

  test.case = '[ a, c ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.c ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );
  group.finit();

  test.case = '[ a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );
  group.finit();

  test.case = '[ j, a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'j', 'a', 'b', 'e', 'c' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )
  group.finit();

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'array, single group' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = '[ a, c ]';
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.c ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'array, single group' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();

  test.case = '[ a ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a', 'b', 'e', 'c' ]);
  var dst = new Set([ gr.a ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );
  group.finit();

  test.case = '[ a, c ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a', 'c', 'b', 'e' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );
  group.finit();

  test.case = '[ a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a', 'b', 'e', 'c' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst );
  group.finit();

  test.case = '[ j, a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.is( got === dst )
  group.finit();

  gr.sys.finit();

  test.close( 'set' );

  /* - */

} /* end of function sourcesFromRoots */

//

function rootsToAllReachable( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = gr.a;
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.c ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.b ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.rootsToAllReachable( dst );
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
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsToAll( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]; /* d, g, j */
  var dst = gr.a;
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]; /* d, g, j */
  var dst = [ gr.a ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];  /* d, g, j */
  var dst = [ gr.a, gr.c ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];  /* d, g, j */
  var dst = [ gr.a, gr.b ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];  /* d, g */
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-2 );
  test.is( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]; /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = gr.a;
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.is( got instanceof _.containerAdapter.Array );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.a ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.is( got instanceof _.containerAdapter.Set );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.is( got.original === dst );

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.is( got.original === dst );

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.is( got.original === dst );

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-2 );
  test.is( got.original === dst );

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
  var expectedDws = [ 'j', 'i', 'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a' ];
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
  var expectedDws = [ 'i', 'h', 'c', 'f', 'e', 'b', 'a' ];
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
  var expectedDws = [ 'c', 'i', 'f', 'e', 'h', 'b', 'g', 'a', 'd' ];
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
  var expectedDws = [ 'c', 'i', 'f', 'e', 'h', 'b', 'g', 'a', 'd' ];
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

function lookBfsVisitedContainter( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      visitedContainer : [ gr.a ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [];
    var expectedUps = [];
    var expectedDws = [];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookBfsVisitedContainter */

//

function lookBfsSuspending( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, revisiting:0';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      revisiting : 0,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'd', 'b', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.case = 'only a, revisiting:1';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      revisiting : 1,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'd', 'b', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.case = 'only a, revisiting:2';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      revisiting : 2,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'd', 'b', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.case = 'only a, revisiting:3';

    clean();
    group.lookBfs
    ({
      roots : gr.a,
      revisiting : 3,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'd', 'b', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level === 2 )
    it.continueNode = false;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookBfsSuspending */

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
    it.continueUp = false;
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
    it.continueUp = false;
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerDown( nodes, it )
  {
    debugger;
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  test.description = 'setup';
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
    var expectedDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];

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
    var expectedDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];

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
    var expectedDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];

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
    var expectedDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];

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

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'f' ];
    var expectedDws = [ 'f', 'a', 'f', 'e', 'b', 'd', 'c', 'd', 'b', 'a' ];

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
    var expectedDws = [ 'f', 'd', 'f', 'e', 'c', 'a', 'b', 'd', 'c', 'b' ];

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

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedDws = [ 'a', 'f', 'e', 'b', 'd', 'c', 'e', 'c', 'f', 'a', 'd', 'b', 'b', 'd', 'f', 'e', 'c', 'a', 'f', 'e', 'b', 'd', 'c', 'd', 'b', 'a' ];

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

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    var expectedDws = [ 'b', 'd', 'f', 'e', 'c', 'a', 'a', 'f', 'e', 'b', 'd', 'c', 'e', 'c', 'f', 'a', 'd', 'b', 'b', 'd', 'f', 'e', 'c', 'a', 'b', 'd', 'c', 'b' ];

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

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'e', 'f', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a' ];
    var expectedDws = [ 'a', 'f', 'e', 'b', 'd', 'c', 'e', 'c', 'f', 'a', 'd', 'b', 'b', 'd', 'f', 'e', 'c', 'a', 'f', 'e', 'b', 'd', 'c', 'd', 'b', 'a' ];

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

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'b', 'b', 'd', 'a', 'f', 'c', 'e', 'c', 'd', 'b', 'e', 'f', 'a', 'a', 'c', 'e', 'f', 'd', 'b' ];
    var expectedDws = [ 'b', 'd', 'f', 'e', 'c', 'a', 'a', 'f', 'e', 'b', 'd', 'c', 'e', 'c', 'f', 'a', 'd', 'b', 'b', 'd', 'f', 'e', 'c', 'a', 'b', 'd', 'c', 'b' ];

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
    it.continueUp = false;
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
    it.continueUp = false;
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
    var expectedDws = [ 'd', 'b', 'a' ];
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
    var expectedDws = [ 'd', 'c', 'b' ];
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
    var expectedDws = [ 'd', 'b', 'a' ];
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
    var expectedDws = [ 'd', 'c', 'b' ];
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
    var expectedDws = [ 'd', 'b', 'a' ];
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
    var expectedDws = [ 'd', 'c', 'b' ];
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
    var expectedDws = [ 'd', 'b', 'a' ];
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
    var expectedDws = [ 'd', 'c', 'b' ];
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

function lookBfsRevisitingTrivial( test )
{
  let context = this;
  var ups = [];
  var dws = [];
  var nds = [];
  var upContinueNode = [];
  var downContinueNode = [];
  var upContinueUp = [];
  var downContinueUp = [];
  var upVisited = [];
  var downVisited = [];

  test.description = 'setup';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'revisiting : 0';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    });

    var expectedNds = [ 'a', 'c', 'b' ];
    var expectedUps = [ 'a', 'c', 'b' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    });

    var expectedNds = [ 'a', 'c', 'b' ];
    var expectedUps = [ 'a', 'c', 'b' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true ];
    var expectedUpVisited = [ 0, 0, 0, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true ];
    var expectedDownVisited = [ 1, 1, 0, 0, 0 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedDws = [ 'c', 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
    upContinueNode = [];
    downContinueNode = [];
    upContinueUp = [];
    downContinueUp = [];
    upVisited = [];
    downVisited = [];
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp( nodeHandle, it )
  {
    console.log( 'up', nodeHandle.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    console.log( 'down', nodeHandle.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode2( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp2( nodeHandle, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown2( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode3( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp3( nodeHandle, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown3( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

} /* end of lookBfsRevisitingTrivial */

//

function lookBfsRepeatsRoots( test )
{
  let context = this;
  var ups = [];
  var dws = [];
  var nds = [];
  var upContinueNode = [];
  var downContinueNode = [];
  var upContinueUp = [];
  var downContinueUp = [];
  var upVisited = [];
  var downVisited = [];

  test.description = 'setup';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'revisiting : 0';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    });

    var expectedNds = [ 'a', 'c', 'b' ];
    var expectedUps = [ 'a', 'c', 'b' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    });

    var expectedNds = [ 'a', 'c', 'b' ];
    var expectedUps = [ 'a', 'c', 'b' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true ];
    var expectedUpVisited = [ 0, 0, 0, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true ];
    var expectedDownVisited = [ 1, 1, 0, 0, 0 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedDws = [ 'c', 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
    upContinueNode = [];
    downContinueNode = [];
    upContinueUp = [];
    downContinueUp = [];
    upVisited = [];
    downVisited = [];
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp( nodeHandle, it )
  {
    console.log( 'up', nodeHandle.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    console.log( 'down', nodeHandle.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode2( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp2( nodeHandle, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown2( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode3( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp3( nodeHandle, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown3( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

} /* end of lookBfsRepeatsRoots */

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

function lookDfsVisitedContainter( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      visitedContainer : [ gr.a ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [];
    var expectedUps = [];
    var expectedDws = [];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookDfsVisitedContainter */

//

function lookDfsSuspending( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, revisiting:0';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      revisiting : 0,
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

    /* - */

    test.case = 'only a, revisiting:1';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      revisiting : 1,
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

    /* - */

    test.case = 'only a, revisiting:2';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      revisiting : 2,
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

    /* - */

    test.case = 'only a, revisiting:3';

    clean();
    group.lookDfs
    ({
      roots : gr.a,
      revisiting : 3,
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

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level === 2 )
    it.continueNode = false;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookDfsSuspending */

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
    it.continueUp = false;
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
    it.continueUp = false;
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

function lookDfsRevisitingTrivial( test )
{
  let context = this;
  var ups = [];
  var dws = [];
  var nds = [];
  var upContinueNode = [];
  var downContinueNode = [];
  var upContinueUp = [];
  var downContinueUp = [];
  var upVisited = [];
  var downVisited = [];

  test.description = 'setup';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'revisiting : 0';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    });

    var expectedNds = [ 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    });

    var expectedNds = [ 'a', 'b', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true ];
    var expectedUpVisited = [ false, false, true, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'b', 'a', 'b', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'b', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, false, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
    upContinueNode = [];
    downContinueNode = [];
    upContinueUp = [];
    downContinueUp = [];
    upVisited = [];
    downVisited = [];
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp( nodeHandle, it )
  {
    console.log( 'up', nodeHandle.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    console.log( 'down', nodeHandle.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode2( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp2( nodeHandle, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown2( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode3( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp3( nodeHandle, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown3( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

} /* end of lookDfsRevisitingTrivial */

//

function lookDfsRepeatsRoots( test )
{
  let context = this;
  var ups = [];
  var dws = [];
  var nds = [];
  var upContinueNode = [];
  var downContinueNode = [];
  var upContinueUp = [];
  var downContinueUp = [];
  var upVisited = [];
  var downVisited = [];

  test.description = 'setup';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'revisiting : 0';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    });

    var expectedNds = [ 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    });

    var expectedNds = [ 'a', 'b', 'c', 'a', 'b', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'a', 'b', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true, true, false, true, true, true ];
    var expectedUpVisited = [ false, false, true, false, false, false, true, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true, true, false, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    group.lookDfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'b', 'a', 'b', 'c', 'c', 'a', 'b', 'a', 'b', 'c', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'b', 'c', 'c', 'a', 'b', 'a', 'b', 'c', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, false, true, true, true, true, false, false, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, false, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
    upContinueNode = [];
    downContinueNode = [];
    upContinueUp = [];
    downContinueUp = [];
    upVisited = [];
    downVisited = [];
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp( nodeHandle, it )
  {
    // console.log( 'up', nodeHandle.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    // console.log( 'down', nodeHandle.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode2( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp2( nodeHandle, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown2( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode3( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp3( nodeHandle, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown3( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

} /* end of lookDfsRepeatsRoots */

//

function lookCfs( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a';

    clean();
    group.lookCfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookCfs */

//

function lookCfsVisitedContainter( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a';

    clean();
    group.lookCfs
    ({
      roots : gr.a,
      visitedContainer : [ gr.a ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [];
    var expectedUps = [];
    var expectedDws = [];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookCfsVisitedContainter */

//

function lookCfsSuspending( test )
{
  let context = this;

  var ups = [];
  var dws = [];
  var nds = [];

  test.description = 'setup';
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  gr.sys.finit();

  /* - */

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, revisiting:0';

    clean();
    group.lookCfs
    ({
      roots : gr.a,
      revisiting : 0,
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

    /* - */

    test.case = 'only a, revisiting:1';

    clean();
    group.lookCfs
    ({
      roots : gr.a,
      revisiting : 1,
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

    /* - */

    test.case = 'only a, revisiting:2';

    clean();
    group.lookCfs
    ({
      roots : gr.a,
      revisiting : 2,
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

    /* - */

    test.case = 'only a, revisiting:3';

    clean();
    group.lookCfs
    ({
      roots : gr.a,
      revisiting : 3,
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

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level === 2 )
    it.continueNode = false;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

} /* end of lookCfsSuspending */

//

function lookCfsRevisiting( test )
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
    it.continueUp = false;
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
    group.lookCfs
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

    debugger;
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
    ({
      roots : gr.a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    // var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ]
    var expectedDws = [ 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'a' ];
    // var expectedDws = [ 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'a' ]
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only b';

    clean();
    group.lookCfs
    ({
      roots : gr.b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    // var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ]
    var expectedDws = [ 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b' ];
    // var expectedDws = [ 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b' ]
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only e';

    clean();
    group.lookCfs
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
    group.lookCfs
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
    // var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    // var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* - */

    test.close( 'revisiting : 3' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookCfsRevisiting */

//

function lookCfsExcluding( test )
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
    debugger;
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
    it.continueUp = false;
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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
    group.lookCfs
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

} /* end of lookCfsExcluding */

//

function lookCfsRevisitingTrivial( test )
{
  let context = this;
  var ups = [];
  var dws = [];
  var nds = [];
  var upContinueNode = [];
  var downContinueNode = [];
  var upContinueUp = [];
  var downContinueUp = [];
  var upVisited = [];
  var downVisited = [];

  test.description = 'setup';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'revisiting : 0';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    });

    var expectedNds = [ 'a', 'c', 'b' ];
    var expectedUps = [ 'a', 'c', 'b' ];
    var expectedDws = [ 'b', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c' ];
    var expectedUps = [ 'a', 'c', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, true ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
    upContinueNode = [];
    downContinueNode = [];
    upContinueUp = [];
    downContinueUp = [];
    upVisited = [];
    downVisited = [];
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp( nodeHandle, it )
  {
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode2( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp2( nodeHandle, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown2( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode3( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp3( nodeHandle, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown3( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

} /* end of lookCfsRevisitingTrivial */

//

function lookCfsRepeatsRoots( test )
{
  let context = this;
  var ups = [];
  var dws = [];
  var nds = [];
  var upContinueNode = [];
  var downContinueNode = [];
  var upContinueUp = [];
  var downContinueUp = [];
  var upVisited = [];
  var downVisited = [];

  test.description = 'setup';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  gr.sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'revisiting : 0';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    });

    var expectedNds = [ 'a', 'c', 'b' ];
    var expectedUps = [ 'a', 'c', 'b' ];
    var expectedDws = [ 'b', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'b', 'c', 'a', 'c', 'c' ]
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, false, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, true, false, false, true ]
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'b', 'c', 'a', 'c', 'c' ]
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, false, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    group.lookCfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'c', 'b', 'c', 'a', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, true, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ]
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, false, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ]

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
    upContinueNode = [];
    downContinueNode = [];
    upContinueUp = [];
    downContinueUp = [];
    upVisited = [];
    downVisited = [];
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp( nodeHandle, it )
  {
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode2( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp2( nodeHandle, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown2( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

  function onNode3( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  function onUp3( nodeHandle, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( nodeHandle );
  }

  function onDown3( nodeHandle, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( nodeHandle );
  }

} /* end of lookCfsRepeatsRoots */

// {
//   let context = this;
//
//   var ups = [];
//   var dws = [];
//   var nds = [];
//
//   function clean()
//   {
//     ups = [];
//     dws = [];
//     nds = [];
//   }
//
//   function onNode( nodeHandle, it )
//   {
//     nds.push( nodeHandle );
//   }
//
//   function onUp( nodeHandle, it )
//   {
//     // debugger;
//     // if( it.level > 1 )
//     // it.continueNode = 0;
//     // if( it.continueNode )
//     ups.push( nodeHandle );
//   }
//
//   function onDown( nodeHandle, it )
//   {
//     // if( it.continueNode )
//     dws.push( nodeHandle );
//   }
//
//   // function handleUp2( nodeHandle, it )
//   // {
//   //   if( it.level > 0 )
//   //   it.continueUp = false;
//   //   ups.push( nodeHandle );
//   // }
//   //
//   // function handleDown2( nodeHandle, it )
//   // {
//   //   dws.push( nodeHandle );
//   // }
//
//   test.description = 'setup';
//   var gr = context.cycled1Scc();
//   var group = gr.sys.nodesGroup();
//
//   run({ fast : 1 });
//   // run({ fast : 0 });
//
//   /* - */
//
//   gr.sys.finit();
//
//   function run( o )
//   {
//
//     test.open( 'fast : ' + o.fast );
//
//     /* - */
//
//     // test.case = 'control, revisiting : 0';
//     //
//     // clean();
//     // group.lookCfs
//     // ({
//     //   roots : [ gr.a, gr.c ],
//     //   onUp : onUp,
//     //   onDown : onDown,
//     //   onNode : onNode,
//     //   fast : o.fast,
//     //   revisiting : 0,
//     // });
//     //
//     // var expectedNds = [ 'a', 'b', 'c' ];
//     // var expectedUps = [ 'a', 'b', 'c' ];
//     // var expectedDws = [ 'b', 'c', 'a' ];
//     //
//     // test.identical( group.nodesToNames( nds ), expectedNds );
//     // test.identical( group.nodesToNames( ups ), expectedUps );
//     // test.identical( group.nodesToNames( dws ), expectedDws );
//
//     /* - */
//
//     test.case = 'control, revisiting : 1';
//
//     clean();
//     group.lookCfs
//     ({
//       roots : [ gr.a, gr.c ],
//       onUp : onUp,
//       onDown : onDown,
//       onNode : onNode,
//       fast : o.fast,
//       revisiting : 1,
//     });
//
//     var expectedNds = [ 'a', 'c', 'b', 'c' ];
//     var expectedUps = [ 'a', 'c', 'b', 'c' ];
//     var expectedDws = [ 'b', 'c', 'a', 'c' ];
//
//     test.identical( group.nodesToNames( nds ), expectedNds );
//     test.identical( group.nodesToNames( ups ), expectedUps );
//     test.identical( group.nodesToNames( dws ), expectedDws );
//
//     /* - */
//
//     test.case = 'control, revisiting : 2';
//
//     clean();
//     group.lookCfs
//     ({
//       roots : [ gr.a, gr.c ],
//       onUp : onUp,
//       onDown : onDown,
//       onNode : onNode,
//       fast : o.fast,
//       revisiting : 2,
//     });
//
//     var expectedNds = [ 'a', 'c', 'b', 'c', 'a' ];
//     var expectedUps = [ 'a', 'c', 'b', 'c', 'a' ];
//     var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
//
//     test.identical( group.nodesToNames( nds ), expectedNds );
//     test.identical( group.nodesToNames( ups ), expectedUps );
//     test.identical( group.nodesToNames( dws ), expectedDws );
//
//     // /* - */
//     //
//     // test.case = 'revisiting : 0';
//     //
//     // clean();
//     // group.lookCfs
//     // ({
//     //   roots : [ gr.a, gr.a ],
//     //   onUp : onUp,
//     //   onDown : onDown,
//     //   onNode : onNode,
//     //   fast : o.fast,
//     //   revisiting : 0,
//     // });
//     //
//     // var expectedNds = [ 'a', 'b', 'c' ];
//     // var expectedUps = [ 'a', 'b', 'c' ];
//     // var expectedDws = [ 'b', 'c', 'a' ];
//     //
//     // test.identical( group.nodesToNames( nds ), expectedNds );
//     // test.identical( group.nodesToNames( ups ), expectedUps );
//     // test.identical( group.nodesToNames( dws ), expectedDws );
//     //
//     // /* - */
//     //
//     // test.case = 'revisiting : 1';
//     //
//     // clean();
//     // group.lookCfs
//     // ({
//     //   roots : [ gr.a, gr.a ],
//     //   onUp : onUp,
//     //   onDown : onDown,
//     //   onNode : onNode,
//     //   fast : o.fast,
//     //   revisiting : 1,
//     // });
//     //
//     // var expectedNds = [ 'a', 'a', 'b', 'c', 'b', 'c' ];
//     // var expectedUps = [ 'a', 'a', 'b', 'c', 'b', 'c' ];
//     // var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a' ];
//     //
//     // test.identical( group.nodesToNames( nds ), expectedNds );
//     // test.identical( group.nodesToNames( ups ), expectedUps );
//     // test.identical( group.nodesToNames( dws ), expectedDws );
//     //
//     // /* - */
//     //
//     // test.case = 'revisiting : 2';
//     //
//     // clean();
//     // group.lookCfs
//     // ({
//     //   roots : [ gr.a, gr.a ],
//     //   onUp : onUp,
//     //   onDown : onDown,
//     //   onNode : onNode,
//     //   fast : o.fast,
//     //   revisiting : 2,
//     // });
//     //
//     // var expectedNds = [ 'a', 'a', 'b', 'c', 'b', 'c' ];
//     // var expectedUps = [ 'a', 'a', 'b', 'c', 'b', 'c' ];
//     // var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a' ];
//     //
//     // test.identical( group.nodesToNames( nds ), expectedNds );
//     // test.identical( group.nodesToNames( ups ), expectedUps );
//     // test.identical( group.nodesToNames( dws ), expectedDws );
//
//     /* - */
//
//     test.close( 'fast : ' + o.fast );
//   }
//
// } /* end of lookCfsRepeatsRoots */

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
  var gr = context.cycledGamma();
  var group = gr.sys.nodesGroup();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];
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
  var expDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];
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
  var expDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];
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
  var expDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];
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

  test.case = 'withBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.a, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.b, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.e, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : gr.f, withBranches : 0 });
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
  var expDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];
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
  var expDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];
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
  var expDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];
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
  var expDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];
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
  var expDws = [ 'f', 'e', 'c', 'd', 'b', 'a' ];
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
  var expDws = [ 'f', 'e', 'a', 'd', 'c', 'b' ];
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
  var expDws = [ 'd', 'b', 'a' ];
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
  var expDws = [ 'd', 'c', 'b' ];
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

  test.case = 'withBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.a, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.b, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.e, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : gr.f, withBranches : 0 });
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

function eachCfs( test )
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, withStem : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, withBranches : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, withBranches : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, withTerminals : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, withTerminals : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, withTerminals : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, withTerminals : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, withTerminals : 0, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, withTerminals : 0, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, withTerminals : 0, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, withTerminals : 0, withStem : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, withTerminals : 0, withStem : 0, mandatory : 1 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, withTerminals : 0, withStem : 0, mandatory : 1 });
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, withTerminals : 0, withStem : 0, mandatory : 1 });
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, withTerminals : 0, withStem : 0, mandatory : 1 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, recursive : 1 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, recursive : 1 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, recursive : 1 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, recursive : 1 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.a, recursive : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.b, recursive : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.e, recursive : 0 });
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookCfs', roots : gr.f, recursive : 0 });
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachCfs */

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
  var ordering = group.dagTopSortDfs( group.rootsToAllReachable([ gr.d ]) );
  var expected = [ 'c', 'd' ];
  test.identical( group.nodesToNames( ordering ), expected );

  test.shouldThrowErrorSync( () =>
  {
    test.description = 'b';
    var ordering = group.dagTopSortDfs([ gr.b ]);
    var expected = [ 'c', 'd', 'f', 'e', 'b' ];
    test.identical( group.nodesToNames( ordering ), expected );
  });

  /* - */

  test.case = 'cycled';
  var gr = context.cycled4Scc();

  test.description = 'explicit all';
  var group = gr.sys.nodesGroup();
  var ordering = group.dagTopSortDfs( [ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i, gr.j ] );
  var expected = [ 'c', 'f', 'i', 'h', 'e', 'b', 'a', 'g', 'd', 'j' ];
  test.identical( group.nodesToNames( ordering ), expected );
  group.finit();

  test.description = 'gr.a, gr.b';
  var group = gr.sys.nodesGroup();
  test.shouldThrowErrorSync( () =>
  {
    var ordering = group.dagTopSortDfs( [ gr.a, gr.b ] );
  });
  group.finit();

  gr.sys.finit();

  /* - */

}

//

function topSortLeastDegreeBfs( test )
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
  var group = gr.sys.nodesGroup();
  var layers = group.topSortLeastDegreeBfs( gr.nodes );
  var expected = [ 'd', 'j', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );
  group.finit();

  /* */

  test.description = 'not j';
  var group = gr.sys.nodesGroup();
  var layers = group.topSortLeastDegreeBfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );
  group.finit();

  /* */

  test.description = 'not j, not d';
  var group = gr.sys.nodesGroup();
  group.cacheInNodesFromOutNodesOnce( gr.nodes );
  var layers = group.topSortLeastDegreeBfs([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'c', 'e', 'g', 'i', 'b', 'a', 'h', 'f' ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );
  group.finit();

  /* */

  test.description = 'c, e - without adding nodes';
  var group = gr.sys.nodesGroup();
  var layers = group.topSortLeastDegreeBfs([ gr.c, gr.e ]);
  var expected = [ 'e', 'a', 'c', 'h', 'b', 'i', 'f' ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );
  group.finit();

  /* */

  test.description = 'c, e - with adding all nodes';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  var layers = group.topSortLeastDegreeBfs([ gr.c, gr.e ]);
  var expected = [ 'e', 'a', 'c', 'h', 'b', 'i', 'f' ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );
  group.finit();

  /* */

  test.description = 'c, e';

  var group = gr.sys.nodesGroup();
  group.cacheInNodesFromOutNodesOnce( gr.nodes );
  var layers = group.topSortLeastDegreeBfs([ gr.c, gr.e ]);
  var expected = [ 'c', 'e', 'b', 'a', 'h', 'f', 'i' ];
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
  var layers = group.topSortLeastDegreeBfs();
  var expected = [ 'a', 'b', 'c' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  gr.sys.finit();

}

//

function topSortCycledSourceBasedFastBfs( test )
{
  let context = this;

  /* - */

  test.case = 'cycled1Scc';
  var gr = context.cycled1Scc();

  /* */

  test.description = 'explicit';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedFastBfs( gr.nodes );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'implicit';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );
  var got = group.topSortCycledSourceBasedFastBfs();
  var expected = [ 'a', 'b', 'c' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();

  test.description = 'explicit';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedFastBfs( gr.nodes );
  var expected = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycledAsymetricChi';

  var gr = context.cycledAsymetricChi();

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedFastBfs( gr.nodes );
  var expected = [ 'd', 'e', 'a', 'b', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  test.description = 'rootsToAllReachable a';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedFastBfs( group.rootsToAllReachable( gr.a ) );
  var expected = [ 'a', 'b', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycled4Scc';

  var gr = context.cycled4Scc();

  /* */

  test.description = 'implicit';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );
  var expected = [ 'j', 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var got = group.topSortCycledSourceBasedFastBfs();
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'not j';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedFastBfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'not j, not d';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedFastBfs([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'g', 'a', 'b', 'e', 'c', 'h', 'f', 'i' ];
  test.identical( group.nodesToNames( got ), expected );

  /* */

  test.description = 'c, e';
  var group = gr.sys.nodesGroup();
  test.shouldThrowErrorSync( () => group.topSortCycledSourceBasedFastBfs([ gr.c, gr.e ]) );
  group.finit();

  gr.sys.finit();

  /* - */
}

//

function topSortCycledSourceBasedPreciseBfs( test )
{
  let context = this;

  /* - */

  test.case = 'cycled1Scc';
  var gr = context.cycled1Scc();

  /* */

  test.description = 'explicit';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPreciseBfs( gr.nodes );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'implicit';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );
  var got = group.topSortCycledSourceBasedPreciseBfs();
  var expected = [ 'a', 'b', 'c' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  gr.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var gr = context.cycledAsymetricZeta();

  test.description = 'explicit';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPreciseBfs( gr.nodes );
  var expected = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycledAsymetricChi';

  var gr = context.cycledAsymetricChi();

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPreciseBfs( gr.nodes );
  // var expected = [ 'd', 'e', 'a', 'b', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  var expected = [ 'a', 'd', 'e', 'b', 'f', 'c', 'g', 'h', 'k', 'j', 'i', 'l', 'm' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  test.description = 'rootsToAllReachable a';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPreciseBfs( group.rootsToAllReachable( gr.a ) );
  // var expected = [ 'a', 'b', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  var expected = [ 'a', 'b', 'c', 'g', 'h', 'k', 'j', 'i', 'l', 'm' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycled4Scc';

  var gr = context.cycled4Scc();

  /* */

  test.description = 'implicit';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( group.infoExport() );
  // var expected = [ 'j', 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expected = [ 'j', 'd', 'g', 'e', 'a', 'c', 'b', 'i', 'f', 'h' ]
  var got = group.topSortCycledSourceBasedPreciseBfs();
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'not j';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPreciseBfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i ]);
// var expected = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expected = [ 'd', 'g', 'e', 'a', 'c', 'b', 'i', 'f', 'h' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'not j, not d';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPreciseBfs([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  // var expected = [ 'g', 'a', 'b', 'e', 'c', 'h', 'f', 'i' ];
  var expected = [ 'g', 'e', 'a', 'c', 'b', 'i', 'h', 'f' ];
  test.identical( group.nodesToNames( got ), expected );

  /* */

  test.description = 'c, e';
  var group = gr.sys.nodesGroup();
  test.shouldThrowErrorSync( () => group.topSortCycledSourceBasedPreciseBfs([ gr.c, gr.e ]) );
  group.finit();

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

  test.case = 'simple';

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

  test.description = 'a h';
  var connected = group.pairDirectedPathGetDfs([ gr.a, gr.h ]);
  test.identical( connected, false );

  test.description = 'h a';
  var exp = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  var connected = group.pairDirectedPathGetDfs([ gr.h, gr.a ]);
  test.identical( group.nodesToNames( connected ), exp );

  gr.sys.finit();

  /* - */

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
  var group = gr.sys.nodesGroup();

  test.description = 'a h';
  var connected = group.pairIsConnectedDfs([ gr.a, gr.h ]);
  test.identical( connected, true );

  test.description = 'h a';
  var connected = group.pairIsConnectedDfs([ gr.h, gr.a ]);
  test.identical( connected, true );

  gr.sys.finit();

  /* - */

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

  /* - */

  test.case = 'cycled3Scc';

  var gr = context.cycled3Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'explicit';
  var layers = group.nodesConnectedLayersDfs( group.nodes );
  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  test.identical( layers.map( ( layer ) => group.nodesToIds( layer ) ), expected );
  var expected =
  [
    [ 'a', 'b', 'c', 'd' ],
    [ 'e' ],
    [ 'f', 'g', 'h' ]
  ]
  test.identical( layers.map( ( layer ) => group.nodesToNames( layer ) ), expected );

  test.description = 'implicit';
  var layers = group.nodesConnectedLayersDfs();
  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  test.identical( layers.map( ( layer ) => group.nodesToIds( layer ) ), expected );
  var expected =
  [
    [ 'a', 'b', 'c', 'd' ],
    [ 'e' ],
    [ 'f', 'g', 'h' ]
  ]
  test.identical( layers.map( ( layer ) => group.nodesToNames( layer ) ), expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycledAsymetricZeta';
  var gr = context.cycledAsymetricZeta();

  test.description = 'implicit';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  var layers = group.nodesConnectedLayersDfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h ]);
  var expected = [ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ] ]
  test.identical( layers.map( ( layer ) => group.nodesToNames( layer ) ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

}

//

function nodesStronglyConnectedLayersDfs( test )
{
  let context = this;

  test.case = 'trivial';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  var layers = group.nodesStronglyConnectedLayersDfs( group.nodes );
  var exp =
  [
    [ 'j' ],
    [ 'f' ],
    [ 'i', 'h' ],
    [ 'g' ],
    [ 'a', 'b', 'e', 'c' ],
    [ 'd' ]
  ]
  var names = layers.map( ( nodes ) => group.nodesToNames( nodes ) );
  test.identical( names, exp );

  gr.sys.finit();

}

//

function nodesStronglyConnectedTreeDfs( test )
{
  let context = this;

  /* - */

  test.case = 'cycled1Scc';
  var gr = context.cycled1Scc();

  /* */

  var group = gr.sys.nodesGroup({});

  group.nodesAdd( gr.nodes );
  logger.log( 'Original' );
  logger.log( group.infoExport() );

  var group2 = group.nodesStronglyConnectedTreeDfs();
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  logger.log( 'Strongly connected tree :\n' + group2.infoExport() );
  var originalNodesNames = group2.nodes.map( ( node ) => group.nodesToNames( node.originalNodes ).toArray().original ).toArray().original;
  var expected = [ [ 'c' ], [ 'a', 'b' ] ];
  test.identical( originalNodesNames, expected );

  var outNodes = group2.nodes.map( ( node ) => group2.nodesToIds( node.outNodes ).toArray().original ).toArray().original;
  var expected = [ [], [ 4 ] ];
  test.identical( outNodes, expected );

  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'c : ', 'a+b : c' ];
  test.identical( outNodes, expected );

  /* */

  gr.sys.finit();

  /* - */

  test.case = 'cycled cycledAsymetricZeta zeta';
  var gr = context.cycledAsymetricZeta();

  /* */

  test.description = 'all, explicit';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( gr.nodes );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );
  group.finit();

  /* */

  test.description = '[ a, h, g, f, e, d, c, b ]';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs([ gr.a, gr.h, gr.g, gr.f, gr.e, gr.d, gr.c, gr.b ]);
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'h+f+g : ', 'e : h+f+g', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all a';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsToAllReachable( gr.a ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all c';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsToAllReachable( gr.c ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'c+a+b : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all d';
  var group = gr.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsToAllReachable( gr.d ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e' ];
  test.identical( outNodes, expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycled4Scc'
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
  var expected = [ 'j : ', 'f : ', 'i+h : f', 'g : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
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
  var expected = [ 'j : ', 'f : ', 'i+h : f', 'g : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
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
  var expected = [ 'f : ', 'i+h : f', 'g : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
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

function rootsExportInfoTree( test )
{
  let context = this;

  test.case = 'cycled4Scc';
  var gr = context.cycled4Scc();

  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
  logger.log( 'DAG' )
  logger.log( group.nodesInfoExport() );
  group.finit();

  test.description = 'single a';
  var group = gr.sys.nodesGroup();
  // group.nodesAdd( gr.nodes );
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
  var infoAsTree = group.rootsExportInfoTree([ gr.a ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );
  group.finit();

  test.description = 'single b';
  var group = gr.sys.nodesGroup();
  // group.nodesAdd( gr.nodes );
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
  var infoAsTree = group.rootsExportInfoTree([ gr.b ]);
  var group = gr.sys.nodesGroup();
  // group.nodesAdd( gr.nodes );
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );
  group.finit();

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
  var infoAsTree = group.rootsExportInfoTree([ gr.a, gr.b, gr.c ]);
  var group = gr.sys.nodesGroup();
  // group.nodesAdd( gr.nodes );
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );
  group.finit();

  test.description = 'multiple, rootsDelimiting : 0';
  var group = gr.sys.nodesGroup();
  group.nodesAdd( gr.nodes );
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
  var infoAsTree = group.rootsExportInfoTree( [ gr.a, gr.b, gr.c ], { rootsDelimiting : 0 } );
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );
  group.finit();

  test.description = 'multiple + sourcesOnlyAmong a, g';
  var group = gr.sys.nodesGroup();
  var exp = [ 'g' ];
  var sources = group.sourcesOnlyAmong( group.rootsToAllReachable([ gr.a, gr.g ]) );
  test.identical( group.nodesToNames( sources.original ), exp );
  var exp =
`
+-- g
  +-- h
    +-- i
      +-- f
`
  var infoAsTree = group.rootsExportInfoTree( sources );
  test.equivalent( infoAsTree, exp );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.description = 'multiple + leastIndegreeOnlyAmong a';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'e', 'c', 'i' ];
  var sources = group.leastIndegreeOnlyAmong( group.rootsToAllReachable([ gr.a ]) );
  test.identical( group.nodesToNames( sources.original ), exp );
  var exp =
`
 +-- a
 | +-- b
 |   +-- e
 |   | +-- c
 |   | +-- h
 |   |   +-- i
 |   |     +-- f
 |   +-- f
 |
 +-- e
 | +-- a
 | | +-- b
 | |   +-- f
 | +-- c
 | | +-- b
 | |   +-- f
 | +-- h
 |   +-- i
 |     +-- f
 |
 +-- c
 | +-- b
 |   +-- e
 |   | +-- a
 |   | +-- h
 |   |   +-- i
 |   |     +-- f
 |   +-- f
 |
 +-- i
   +-- f
   +-- h
`
  var infoAsTree = group.rootsExportInfoTree( sources );
  test.equivalent( infoAsTree, exp );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.description = 'multiple + leastOutdegreeOnlyAmong a';
  var group = gr.sys.nodesGroup();
  var exp = [ 'f' ];
  var sources = group.leastOutdegreeOnlyAmong( group.rootsToAllReachable([ gr.a ]) );
  test.identical( group.nodesToNames( sources.original ), exp );
  var exp = `+-- f`;
  var infoAsTree = group.rootsExportInfoTree( sources );
  test.equivalent( infoAsTree, exp );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.description = 'multiple + sourcesOnlyAmong a';
  var group = gr.sys.nodesGroup();
  var exp = [];
  var sources = group.sourcesOnlyAmong( group.rootsToAllReachable([ gr.a ]) );
  test.identical( group.nodesToNames( sources.original ), exp );
  var exp = '';
  var infoAsTree = group.rootsExportInfoTree( sources );
  test.equivalent( infoAsTree, exp );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

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

} /* end of function rootsExportInfoTree */

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
    sourcesFromNodes,
    sourcesFromRoots,
    rootsToAllReachable,
    rootsToAll,

    sinksOnlyAmong,
    sourcesOnlyAmong,
    leastMostDegreeAmong,

    lookBfs,
    lookBfsVisitedContainter,
    lookBfsSuspending,
    lookBfsRevisiting,
    lookBfsExcluding,
    lookBfsRevisitingTrivial,
    lookBfsRepeatsRoots,

    lookDfs,
    lookDfsVisitedContainter,
    lookDfsSuspending,
    lookDfsRevisiting,
    lookDfsExcluding,
    lookDfsRevisitingTrivial,
    lookDfsRepeatsRoots,

    lookCfs,
    lookCfsVisitedContainter,
    lookCfsSuspending,
    lookCfsRevisiting,
    lookCfsExcluding,
    lookCfsRevisitingTrivial,
    lookCfsRepeatsRoots,

    eachBfs,
    eachDfs,
    eachCfs,

    dagTopSortDfs,
    topSortLeastDegreeBfs,
    topSortCycledSourceBasedFastBfs,
    topSortCycledSourceBasedPreciseBfs,

    // connectivity

    pairDirectedPathGetDfs,
    pairDirectedPathExistsDfs,
    pairIsConnectedDfs,
    pairIsConnectedStronglyDfs,

    nodesConnectedLayersDfs,
    nodesStronglyConnectedLayersDfs,
    nodesStronglyConnectedTreeDfs,

    rootsExportInfoTree,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
