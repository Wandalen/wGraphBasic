( function _AbstractGraph_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../graphBasic/IncludeTop.s' );

}

const _ = _global_.wTools;

// --
// context
// --

function dag6()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled0Scc()
{
  let context = this;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }

/*

    a ↔ b ↩
    ↓
    c

*/

  a.nodes.push( b, c );
  b.nodes.push( a, b );
  c.nodes.push();

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );
  return gr;
}

//

function cycled1Scc()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );
  return gr;
}

//

function cycled2Scc()
{
  let context = this;
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

/*
revistings:0
DFS
a
-b
-c
--e

revistings:1
DFS
a
-b
-c
--e
---b

revistings:2
DFS
a
-b
--a
-c
--e
---b
----a
*/

  a.nodes.push( b, c );
  b.nodes.push( a );
  // c.nodes.push( a, e );
  c.nodes.push( e );
  d.nodes.push();
  e.nodes.push( c, b );

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled3Scc()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycled4Scc()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h, i, j ];
  gr.connectedNodes = [ a, b, c, d, e, f, g, h, i ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function _cycledJunctions( gr, o )
{
  let context = this;

  o = _.routine.options_( _cycledJunctions, o );

  gr.length = gr.nodes.length;
  gr.sys = new _.graph.AbstractGraphSystem
  ({
    onNodeName : ( node ) =>
    {
      _.assert( node.original === undefined );
      _.assert( _.arrayIs( node.nodes ) );
      return node.name;
    },
    onNodeOutNodes : onNodeOutNodes,
    onNodeJunction : ( node ) =>
    {
      return gr.junctionFrom( node );
    },
  });

  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );
  gr.nodeToJunction = new HashMap;
  gr.junctionFrom = function junctionFrom( node )
  {
    _.assert( !!node && node.original === undefined );
    _.assert( _.arrayIs( node.nodes ) );
    if( gr.nodeToJunction.has( node ) )
    return gr.nodeToJunction.get( node );
    let junction = Object.create( null );
    gr.nodeToJunction.set( node, junction );
    junction.original = [];
    junction.out = [];
    junction.in = [];
    gr.nodes.forEach( ( node2 ) =>
    {
      if( node2.name[ 0 ] === node.name[ 0 ] )
      {
        junction.original.push( node2 );
        gr.nodeToJunction.set( node2, junction );
      }
    });
    gr.nodes.forEach( ( node2 ) =>
    {
      if( node2.name[ 0 ] === node.name[ 0 ] )
      {
        _.arrayAppendArrayOnce( junction.out, node2.nodes.map( ( node3 ) => gr.junctionFrom( node3 ) ) );
      }
      node2.nodes.forEach( ( node3 ) =>
      {
        if( node3.name[ 0 ] === node.name[ 0 ] )
        _.arrayAppendOnce( junction.in, gr.junctionFrom( node2 ) );
      })
    });
    junction.name = junction.original.map( ( original ) => original.name ).join( '+' );
    return junction;
  }

  gr.nodes.forEach( ( node ) => gr.junctionFrom( node ) );

  return gr;

  function onNodeOutNodes( node )
  {
    let group = this;
    _.assert( node.original === undefined );
    _.assert( _.arrayIs( node.nodes ) );
    let result = node.nodes.slice();
    let junction = gr.junctionFrom( node );
    _.arrayAppendArraysOnce( result, junction.out.map( ( junction ) => junction.original ) );
    // logger.log( `Out nodes of ${group.nodeToName( node )} are ${group.nodesToNames( result ).join( ' ' )}` )
    return result;
  }

}

_cycledJunctions.defaults =
{
}

//

function cycledJunctionsTriplet( o )
{
  let context = this;
  var a0 = { name : 'a0', nodes : [] }
  var a1 = { name : 'a1', nodes : [] }
  var a2 = { name : 'a2', nodes : [] }
  var b1 = { name : 'b1', nodes : [] }
  var b2 = { name : 'b2', nodes : [] }
  var c = { name : 'c', nodes : [] }

  if( !arguments.length )
  o = Object.create( null );

/*

   a0 → b1 → a1
      ↘
        c → b2 → a2

*/

  a0.nodes.push();
  a1.nodes.push( c );
  a2.nodes.push( b1 );
  b1.nodes.push( a1 );
  b2.nodes.push( a2 );
  c.nodes.push( b2 );

  let gr = Object.create( null );
  gr.nodes = [ a0, a1, a2, b1, b2, c ];
  return context._cycledJunctions( gr, o );
}

//

function cycledJunctions2( o )
{
  let context = this;
  var a0 = { name : 'a0', nodes : [] }
  var a1 = { name : 'a1', nodes : [] }
  var a2 = { name : 'a2', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }

  if( !arguments.length )
  o = Object.create( null );

/*

   a2
   ⇅
   g ⇆ a1
   ⇅
   a0 → b → c
   ↓
   d → e
     ↖ ↓
       f

*/

  a0.nodes.push( b, d, g );
  a1.nodes.push( b, d, g );
  a2.nodes.push( b, d, g );
  b.nodes.push( c );
  c.nodes.push();
  d.nodes.push( e );
  e.nodes.push( f );
  f.nodes.push( d );
  g.nodes.push( a0, a1, a2 );

  let gr = Object.create( null );
  gr.nodes = [ a0, a1, a2, b, c, d, e, f, g ];
  return context._cycledJunctions( gr, o );
}

//

function cycledJunctions3( o )
{
  let context = this;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c1 = { name : 'c1', nodes : [] }
  var c2 = { name : 'c2', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }

  if( !arguments.length )
  o = Object.create( null );

/*

   g ← c2
   ↓
   a → b → c1
   ↓
   d → e
     ↖ ↓
       f

*/

  a.nodes.push( b, d );
  b.nodes.push( c1 );
  c1.nodes.push();
  c2.nodes.push( g );
  d.nodes.push( e );
  e.nodes.push( f );
  f.nodes.push( d );
  g.nodes.push( a );

  let gr = Object.create( null );
  gr.nodes = [ a, b, c1, c2, d, e, f, g ];
  return context._cycledJunctions( gr, o );
}

//

function cycledJunctions4( o )
{
  let context = this;
  var a = { name : 'a', nodes : [] }
  var b1 = { name : 'b1', nodes : [] }
  var b2 = { name : 'b2', nodes : [] }
  var c1 = { name : 'c1', nodes : [] }
  var c2 = { name : 'c2', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }

  if( !arguments.length )
  o = Object.create( null );

/*

     ↗ c2 → b2
   g
   ↑ ↘ b1 → c1
   a
   ↓
   d → e
     ↖ ↓
       f

*/

  a.nodes.push( d, g );
  b1.nodes.push( c1 );
  b2.nodes.push();
  c1.nodes.push();
  c2.nodes.push( b2 );
  d.nodes.push( e );
  e.nodes.push( f );
  f.nodes.push( d );
  g.nodes.push( b1, c2 );

  let gr = Object.create( null );
  gr.nodes = [ a, b1, b2, c1, c2, d, e, f, g ];
  return context._cycledJunctions( gr, o );
}

//

function cycledJunctions5( o )
{
  let context = this;
  var a0 = { name : 'a0', nodes : [] }
  var a1 = { name : 'a1', nodes : [] }
  var b1 = { name : 'b1', nodes : [] }
  var b2 = { name : 'b2', nodes : [] }
  var c1 = { name : 'c1', nodes : [] }
  var c2 = { name : 'c2', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }
  var g = { name : 'g', nodes : [] }

  if( !arguments.length )
  o = Object.create( null );

/*

     ↗ c2 → b2
   g ↩
   ↑ ↘ b1 → c1
   a0  a1
   ↓
   d → e
     ↖ ↓
       f

*/

  a0.nodes.push( d, g );
  a1.nodes.push();
  b1.nodes.push( c1 );
  b2.nodes.push();
  c1.nodes.push();
  c2.nodes.push( b2 );
  d.nodes.push( e );
  e.nodes.push( f );
  f.nodes.push( d );
  g.nodes.push( b1, c2, g );

  let gr = Object.create( null );
  gr.nodes = [ a0, b1, b2, c1, c2, d, e, f, g, a1 ];
  /*
    a1 should be in the end of the list
  */
  return context._cycledJunctions( gr, o );
}

//

function cycledOmicron()
{
  let context = this;
  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }
  var f = { name : 'f', nodes : [] }

/*

        d
      ↗ ⇅ ↖
    a   b   c
      ↘ ↓ 🡗 ↑
        f → e

*/

  a.nodes.push( d, f );
  b.nodes.push( d, f );
  c.nodes.push( d, f );
  d.nodes.push( b );
  e.nodes.push( c );
  f.nodes.push( e );

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem
  ({
    onNodeName : ( node ) =>
    {
      _.assert( node.original === undefined );
      _.assert( _.arrayIs( node.nodes ) );
      return node.name;
    },
    onNodeOutNodes : ( node ) =>
    {
      _.assert( node.original === undefined );
      _.assert( _.arrayIs( node.nodes ) );
      return node.nodes;
    },
  });
  gr.nodes = [ a, b, c, d, e, f ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycledGamma()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycledAsymetricZeta()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function cycledAsymetricChi()
{
  let context = this;
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

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h, i, j, k, l, m ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}

//

function petersenGraph()
{
  let context = this;
  var a = { name : 'a', nodes : [] };
  var b = { name : 'b', nodes : [] };
  var c = { name : 'c', nodes : [] };
  var d = { name : 'd', nodes : [] };
  var e = { name : 'e', nodes : [] };
  var f = { name : 'f', nodes : [] };
  var g = { name : 'g', nodes : [] };
  var h = { name : 'h', nodes : [] };
  var i = { name : 'i', nodes : [] };
  var j = { name : 'j', nodes : [] };

/*

   ┌────── a ──────┐
  ┌        |        ┐
  e ─┐   ┌ f ┐    ┌─ b
  |  |   /    \   |  |
  │  j ──┼────┼── g  |
  |  |   | ┌───┼──┘  |
   \ └──/──┼──┐ \   /
    |   |  |  | |  |
    | ┌ i ─┘  └─ h ┐ |
    |/              \|
    d ────────────── c

*/

  a.nodes.push( e, b, f );
  b.nodes.push( a, c, g );
  c.nodes.push( b, d, h );
  d.nodes.push( c, e, i );
  e.nodes.push( d, a, j );
  f.nodes.push( a, i, h );
  g.nodes.push( b, j, i );
  h.nodes.push( c, f, j );
  i.nodes.push( d, g, f );
  j.nodes.push( e, h, g );

  let gr = {}
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : ( node ) => node.name });
  gr.nodes = [ a, b, c, d, e, f, g, h, i, j ];
  gr.nodes.forEach( ( e ) => gr[ e.name ] = e );

  return gr;
}
// --
// tests
// --

function makeByNodes( test )
{
  let context = this;

  /* */

  test.case = 'init, add, delete, finit';

  var gr = context.cycled2Scc();
  var collection = gr.sys.nodesCollection();

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  collection.nodesAdd( gr.nodes );

  test.identical( collection.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.a ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( collection.nodes.length, 5 );
  test.identical( collection.nodesToNames().toArray().original, [ 'a', 'b', 'c', 'd', 'e' ] );
  logger.log( collection.exportString() );

  collection.nodeDelete( gr.d );
  test.identical( gr.sys.nodeDescriptorsHash.size, 4 );
  test.identical( collection.nodes.length, 4 );
  test.identical( collection.nodesToNames().toArray().original, [ 'a', 'b', 'c', 'e' ] );
  logger.log( collection.exportString() );

  collection.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.identical( gr.sys.collections.length, 0 );
  gr.sys.finit();

  /* */

  test.case = 'nodesDelete';

  var gr = context.cycled2Scc();
  var collection = gr.sys.nodesCollection();

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  collection.nodesAdd( gr.nodes );

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( collection.nodes.length, 5 );
  test.identical( collection.nodesToNames().toArray().original, [ 'a', 'b', 'c', 'd', 'e' ] );
  logger.log( collection.exportString() );

  collection.nodesDelete([ gr.a, gr.d ]);
  test.identical( gr.sys.nodeDescriptorsHash.size, 3 );
  test.identical( collection.nodes.length, 3 );
  test.identical( collection.nodesToNames().toArray().original, [ 'b', 'c', 'e' ] );
  logger.log( collection.exportString() );

  collection.nodesDelete([ gr.b, gr.c ]);
  test.identical( gr.sys.nodeDescriptorsHash.size, 1 );
  test.identical( collection.nodes.length, 1 );
  test.identical( collection.nodesToNames().toArray().original, [ 'e' ] );
  logger.log( collection.exportString() );

  collection.nodesDelete();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( collection.nodes.length, 0 );
  test.identical( collection.nodesToNames().toArray().original, [] );
  logger.log( collection.exportString() );

  collection.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.identical( gr.sys.collections.length, 0 );
  gr.sys.finit();

  /* */

}

//

function makeByNodesWithInts( test )
{
  let context = this;

  test.case = 'init, add, delete, finit';

  var gr = {};
  function onNodeName( node ){ return node };
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : onNodeName });
  var collection = gr.sys.nodesCollection();

  collection.group.onNodeOutNodes = function onNodeOutNodes( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+gr.outNodes.length );
    let result = gr.outNodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  collection.group.onNodeName = function onNodeName( node )
  {
    return String( node );
  }

  test.true( gr.sys === collection.sys );
  test.true( gr.sys === collection.group.sys );
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

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  collection.nodesAdd( gr.nodes );

  test.identical( collection.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.a ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( collection.nodes.length, 5 );
  test.identical( collection.nodesToNames().toArray().original, [ '11', '12', '13', '14', '15' ] );
  logger.log( collection.exportString() );

  collection.nodeDelete( gr.d );
  test.identical( gr.sys.nodeDescriptorsHash.size, 4 );
  test.identical( collection.nodes.length, 4 );
  test.identical( collection.nodesToNames().toArray().original, [ '11', '12', '13', '15' ] );
  logger.log( collection.exportString() );

  collection.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.identical( gr.sys.collections.length, 0 );
  gr.sys.finit();

  /* */

  test.case = 'nodesDelete';

  var gr = {};
  function onNodeName( node ){ return node };
  gr.sys = new _.graph.AbstractGraphSystem({ onNodeName : onNodeName });
  var collection = gr.sys.nodesCollection();

  test.true( gr.sys.onNodeName === onNodeName );
  test.true( collection.group.onNodeName === onNodeName );

  collection.group.onNodeOutNodes = function onNodeOutNodes( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+gr.outNodes.length );
    let result = gr.outNodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  collection.group.onNodeName = function onNodeName( node )
  {
    return String( node );
  }

  test.true( gr.sys === collection.sys );
  test.true( gr.sys === collection.group.sys );
  test.identical( gr.sys.groups.length, 1 );
  test.identical( gr.sys.collections.length, 1 );

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

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );

  collection.nodesAdd( gr.nodes );

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( collection.nodes.length, 5 );
  test.identical( collection.nodesToNames().toArray().original, [ '11', '12', '13', '14', '15' ] );
  logger.log( collection.exportString() );

  collection.nodesDelete([ gr.a, gr.d ]);
  test.identical( gr.sys.nodeDescriptorsHash.size, 3 );
  test.identical( collection.nodes.length, 3 );
  test.identical( collection.nodesToNames().toArray().original, [ '12', '13', '15' ] );
  logger.log( collection.exportString() );

  collection.nodesDelete( gr.b, gr.c );
  test.identical( gr.sys.nodeDescriptorsHash.size, 1 );
  test.identical( collection.nodes.length, 1 );
  test.identical( collection.nodesToNames().toArray().original, [ '15' ] );
  logger.log( collection.exportString() );

  collection.nodesDelete();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( collection.nodes.length, 0 );
  test.identical( collection.nodesToNames().toArray().original, [] );
  logger.log( collection.exportString() );

  collection.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.collections.length, 0 );
  test.identical( gr.sys.groups.length, 0 );
  gr.sys.finit();

}

//

function groupClone( test )
{
  let context = this;
  var gr = context.cycled2Scc();

  /* */

  test.case = 'trivial';

  var group = gr.sys.nodesGroup();
  var group2 = group.clone();

  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 2 );
  test.identical( group.nodesToNames( gr.nodes ), [ 'a', 'b', 'c', 'd', 'e' ] );
  test.identical( group2.nodesToNames( gr.nodes ), [ 'a', 'b', 'c', 'd', 'e' ] );
  logger.log( group.exportString({ nodes : gr.nodes }) );

  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 1 );
  test.identical( gr.sys.collections.length, 0 );

  group2.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.identical( gr.sys.collections.length, 0 );

  gr.sys.finit();

  /* */

}

//

function collectionClone( test )
{
  let context = this;

  /* */

  test.case = 'trivial';

  var gr = context.cycled2Scc();
  var collection = gr.sys.nodesCollection();
  collection.nodesAdd( gr.nodes );
  var collection2 = collection.clone();

  test.identical( collection.nodes.length, 5 );
  test.identical( collection2.nodes.length, 5 );
  test.identical( gr.sys.collections.length, 2 );
  test.identical( collection.group.nodesToNames( collection.nodes ).toArray().original, [ 'a', 'b', 'c', 'd', 'e' ] );
  test.identical( collection2.group.nodesToNames( collection2.nodes ).toArray().original, [ 'a', 'b', 'c', 'd', 'e' ] );
  logger.log( collection.exportString() );

  collection.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( gr.sys.collections.length, 1 );
  test.identical( gr.sys.groups.length, 1 );

  collection2.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.collections.length, 0 );
  test.identical( gr.sys.groups.length, 0 );

  gr.sys.finit();

  /* */

  test.case = 'node delete';

  var gr = context.cycled2Scc();
  var collection = gr.sys.nodesCollection();
  collection.nodesAdd( gr.nodes );
  var collection2 = collection.clone();

  collection.nodeDelete( gr.a );
  collection2.nodeDelete( gr.b );

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( collection.hasNode( gr.b ), true );
  test.identical( collection2.hasNode( gr.a ), true );
  test.identical( collection2.hasNode( gr.b ), false );
  test.identical( gr.sys.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.b ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 5 );
  test.identical( collection.nodes.length, 4 );
  test.identical( collection2.nodes.length, 4 );
  test.identical( gr.sys.collections.length, 2 );
  test.identical( collection.group.nodesToNames( collection.nodes ).toArray().original, [ 'b', 'c', 'd', 'e' ] );
  test.identical( collection2.group.nodesToNames( collection2.nodes ).toArray().original, [ 'a', 'c', 'd', 'e' ] );
  logger.log( collection.exportString() );

  collection2.nodeDelete( gr.a )
  collection.nodeDelete( gr.b );

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( collection.hasNode( gr.b ), false );
  test.identical( collection2.hasNode( gr.a ), false );
  test.identical( collection2.hasNode( gr.b ), false );
  test.identical( gr.sys.hasNode( gr.a ), false );
  test.identical( gr.sys.hasNode( gr.b ), false );

  test.identical( gr.sys.nodeDescriptorsHash.size, 3 );
  test.identical( collection.nodes.length, 3 );
  test.identical( collection2.nodes.length, 3 );
  test.identical( gr.sys.collections.length, 2 );
  test.identical( collection.group.nodesToNames( collection.nodes ).toArray().original, [ 'c', 'd', 'e' ] );
  test.identical( collection2.group.nodesToNames( collection2.nodes ).toArray().original, [ 'c', 'd', 'e' ] );
  logger.log( collection.exportString() );

  collection.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 3 );
  test.identical( gr.sys.collections.length, 1 );
  test.identical( gr.sys.groups.length, 1 );

  collection2.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.identical( gr.sys.groups.length, 0 );

  /* */

  test.case = 'finit group';

  var gr = context.cycled2Scc();
  var collection = gr.sys.nodesCollection();
  collection.nodesAdd( gr.nodes );
  var collection2 = collection.clone();

  collection.nodesDelete( gr.a, gr.b );
  collection2.nodesDelete( gr.b, gr.c );

  test.identical( collection.hasNode( gr.a ), false );
  test.identical( collection.hasNode( gr.b ), false );
  test.identical( collection.hasNode( gr.c ), true );
  test.identical( collection2.hasNode( gr.a ), true );
  test.identical( collection2.hasNode( gr.b ), false );
  test.identical( collection2.hasNode( gr.c ), false );
  test.identical( gr.sys.hasNode( gr.a ), true );
  test.identical( gr.sys.hasNode( gr.b ), false );
  test.identical( gr.sys.hasNode( gr.c ), true );

  test.identical( gr.sys.nodeDescriptorsHash.size, 4 );
  test.identical( collection.nodes.length, 3 );
  test.identical( collection2.nodes.length, 3 );
  test.identical( gr.sys.collections.length, 2 );
  test.identical( gr.sys.groups.length, 1 );
  test.true( collection.group === collection2.group );
  test.identical( collection.group.nodesToNames( collection.nodes ).toArray().original, [ 'c', 'd', 'e' ] );
  test.identical( collection2.group.nodesToNames( collection2.nodes ).toArray().original, [ 'a', 'd', 'e' ] );
  logger.log( collection.exportString() );

  var group = collection.group;
  group.finit();
  test.identical( gr.sys.nodeDescriptorsHash.size, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.identical( gr.sys.groups.length, 0 );
  test.true( group.isFinited() );
  test.true( collection.isFinited() );
  test.true( collection2.isFinited() );

  /* */

  gr.sys.finit();

}

//

function cacheInNodesJunctions( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctions3';
  var gr = context.cycledJunctions3();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'all nodes';
  var group = gr.sys.nodesGroup();
  group.cacheInNodesFromOutNodesOnce( gr.nodes );
  var exp =
`
a : g
b : a
c1+c2 : b
d : a+f
e : d
f : e
g : c1+c2
`;
  var got = group.cacheInNodesExportInfo();
  test.equivalent( got, exp );

  gr.sys.finit();

  /* - */

}

//

function reverse( test )
{
  let context = this;

  /* */

  test.case = 'cycled 1 scc';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();
  var group2 = group.clone();

  group2.cacheInNodesFromOutNodesOnce( gr.nodes );
  group2.exportString({ nodes : gr.nodes });
  group2.reverse();

  var exp =
`a : b
b : a
c : a`
  test.identical( group2.exportString({ nodes : gr.nodes }), exp );

  var exp =
`a : b c
b : a
c : `
  test.identical( group.exportString({ nodes : gr.nodes }), exp );

  gr.sys.finit();

  /* */

  test.case = 'cycled 4 scc';
  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
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
  test.equivalent( group2.exportString({ nodes : gr.nodes }), exp );
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
  test.equivalent( group.exportString({ nodes : gr.nodes }), exp );

  group2.cacheInNodesFromOutNodesOnce( gr.nodes );
  group2.exportString({ nodes : gr.nodes });
  group2.reverse();
  group2.exportString({ nodes : gr.nodes });

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
  test.equivalent( group.exportString({ nodes : gr.nodes }), exp );

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
  test.equivalent( group2.exportString({ nodes : gr.nodes }), exp );

  test.identical( gr.nodes.length, 10 );
  test.identical( gr.sys.groups.length, 2 );

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
  var outNodes = group.nodesOutNodesFor( gr.nodes ).map( ( nodes ) => group.nodesToNames( nodes ).toArray().original );
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
  var outNodes = group2.nodesOutNodesFor( gr.nodes ).map( ( nodes ) => group2.nodesToNames( nodes ).toArray().original );
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
  var outNodes = group2.nodesInNodesFor( gr.nodes ).map( ( nodes ) => group2.nodesToNames( nodes ).toArray().original );
  test.identical( outNodes, expected );

  group2.reverse();
  test.identical( gr.nodes.length, 10 );

  group.finit();
  test.identical( gr.sys.groups.length, 1 );

  group2.finit();
  test.identical( gr.sys.groups.length, 0 );

  gr.sys.finit();

  /* */

}

//

function asNodes( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = _.setFrom([ 'a' ]);
  var dst = gr.a;
  var got = group.asNodes( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( _.setIs( got ) );

  test.case = '[ a ]';
  var exp = [ 'a' ];
  var dst = [ gr.a ];
  var got = group.asNodes( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( _.arrayIs( got ) );
  test.true( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b' ];
  var dst = [ gr.a, gr.b ];
  var got = group.asNodes( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( _.arrayIs( got ) );
  test.true( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = _.setFrom([ 'a' ]);
  var dst = gr.a;
  var got = group.asNodes( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( _.setIs( got ) );

  test.case = '[ a ]';
  var exp = new Set([ 'a' ]);
  var dst = new Set([ gr.a ]);
  var got = group.asNodes( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( _.setIs( got ) );
  test.true( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.asNodes( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( _.setIs( got ) );
  test.true( got === dst )

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

function sourcesFromNodesJunctions( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctions2';
  var gr = context.cycledJunctions2();

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a2', 'g', 'a1', 'a0' ];
  var got = group.sourcesFromNodes( null, gr.nodes );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycledJunctions4';
  var gr = context.cycledJunctions4();

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a' ];
  var got = group.sourcesFromNodes( null, gr.nodes );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  group.finit();

  gr.sys.finit();

  /* - */

} /* end of function sourcesFromNodesJunctions */

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
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), _.setFrom( exp ) );
  group.finit();

  test.case = '[ a ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );
  group.finit();

  test.case = '[ a, c ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.c ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );
  group.finit();

  test.case = '[ a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );
  group.finit();

  test.case = '[ j, a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = [ 'j', 'a', 'b', 'e', 'c' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst )
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
  test.true( got === dst );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c' ];
  var dst = [ gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst )

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
  test.true( got === dst );
  group.finit();

  test.case = '[ a, c ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a', 'c', 'b', 'e' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );
  group.finit();

  test.case = '[ a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a', 'b', 'e', 'c' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst );
  group.finit();

  test.case = '[ j, a, b ]';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), exp );
  test.true( got === dst )
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
  var exp = _.setFrom([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = gr.a;
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.c ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.a, gr.b ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = _.setFrom([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = gr.a;
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.true( got === dst )

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsToAllReachableJunctions( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctions5';
  var gr = context.cycledJunctions5();

  test.description = 'a0';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'b2', 'c1', 'c2' ]);
  var dst = gr.a0;
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.description = 'g';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'g', 'b1', 'c1', 'b2', 'c2' ]);
  var dst = gr.g;
  var got = group.rootsToAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  gr.sys.finit();

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
  var exp = _.setFrom([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g, j */
  var dst = gr.a;
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.size, gr.nodes.length-3 );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]; /* d, g, j */
  var dst = [ gr.a ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.true( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];  /* d, g, j */
  var dst = [ gr.a, gr.c ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.true( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];  /* d, g, j */
  var dst = [ gr.a, gr.b ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.true( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];  /* d, g */
  var dst = [ gr.j, gr.a, gr.b ];
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-2 );
  test.true( got === dst )

  gr.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  test.case = 'a';
  var exp = _.setFrom([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = gr.a;
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.true( got instanceof _.containerAdapter.Set );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.a ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.true( got instanceof _.containerAdapter.Set );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.true( got.original === dst );

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.a, gr.c ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.true( got.original === dst );

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g, j */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.a, gr.b ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-3 );
  test.true( got.original === dst );

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]); /* d, g */
  exp = _.containerAdapter.from( exp );
  var dst = new Set([ gr.j, gr.a, gr.b ]);
  var got = group.rootsToAll( dst );
  got = _.containerAdapter.from( got );
  test.identical( group.nodesToNames( got ), exp );
  test.identical( got.length, gr.nodes.length-2 );
  test.true( got.original === dst );

  gr.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsToAllJunctions( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctions4';
  var gr = context.cycledJunctions4();

  test.description = 'a';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'a', 'd', 'e', 'f', 'g', 'b1', 'b2', 'c1', 'c2' ]);
  var dst = gr.a;
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.description = 'g';
  var group = gr.sys.nodesGroup();
  var exp = new Set([ 'g', 'b1', 'c1', 'b2', 'c2' ]);
  var dst = gr.g;
  var got = group.rootsToAll( dst );
  test.identical( group.nodesToNames( got ), exp );

  gr.sys.finit();

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

  gr.sys.finit();
}

//

function sourcesOnlyAmong( test )
{
  let context = this;

  test.description = 'setup';

  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();

  var got = group.sourcesOnlyAmong( gr.nodes );
  var expected = [ 'd', 'j' ];
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

  var got = group.leastIndegreeAmong( gr.nodes );
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong( gr.nodes );
  var expected = [ 'd', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostIndegreeAmong( gr.nodes );
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong( gr.nodes );
  var expected = [ 'h' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.leastOutdegreeAmong( gr.nodes );
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong( gr.nodes );
  var expected = [ 'f', 'j' ];
  test.identical( _.containerAdapter.toOriginal( group.nodesToNames( got ) ), expected );

  var got = group.mostOutdegreeAmong( gr.nodes );
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong( gr.nodes );
  var expected = [ 'e' ];
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
  let nds = [];
  let ups = [];
  let dws = [];
  let lups = [];
  let ldws = [];

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

  test.identical( gr.nodes.length, 10 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

  /* */

  test.case = 'all';

  clean();
  var layers = group.lookBfs({ roots : gr.nodes, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    new Set([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ]),
    new Set([])
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedUps = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedDws = [ 'j', 'i', 'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a' ];
  var expectedLups =
  [
    new Set([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ]),
    new Set([ 'b', 'e', 'f', 'b', 'a', 'g', 'a', 'c', 'h', 'h', 'i', 'f', 'h' ]),
  ];
  var expectedLdws =
  [
    new Set([]),
    new Set([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ])
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only a';

  clean();
  var layers = group.lookBfs({ roots : gr.a, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    new Set([ 'a' ]),
    new Set([ 'b' ]),
    new Set([ 'e', 'f' ]),
    new Set([ 'c', 'h' ]),
    new Set([ 'i' ]),
    new Set([])
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedUps = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedDws = [ 'i', 'h', 'c', 'f', 'e', 'b', 'a' ];
  var expectedLups =
  [
    new Set([ 'a' ]),
    new Set([ 'b' ]),
    new Set([ 'e', 'f' ]),
    new Set([ 'a', 'c', 'h' ]),
    new Set([ 'b', 'i' ]),
    new Set([ 'f', 'h' ])
  ]
  var expectedLdws =
  [
    new Set([]),
    new Set([ 'i' ]),
    new Set([ 'c', 'h' ]),
    new Set([ 'e', 'f' ]),
    new Set([ 'b' ]),
    new Set([ 'a' ])
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only d';

  clean();
  var layers = group.lookBfs({ roots : gr.d, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    new Set([ 'd' ]),
    new Set([ 'a', 'g' ]),
    new Set([ 'b', 'h' ]),
    new Set([ 'e', 'f', 'i' ]),
    new Set([ 'c' ]),
    new Set([])
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'c', 'i', 'f', 'e', 'h', 'b', 'g', 'a', 'd' ];
  var expectedLups =
  [
    new Set([ 'd' ]),
    new Set([ 'a', 'g' ]),
    new Set([ 'b', 'h' ]),
    new Set([ 'e', 'f', 'i' ]),
    new Set([ 'a', 'c', 'h', 'f' ]),
    new Set([ 'b' ])
  ]
  var expectedLdws =
  [
    new Set([]),
    new Set([ 'c' ]),
    new Set([ 'e', 'f', 'i' ]),
    new Set([ 'b', 'h' ]),
    new Set([ 'a', 'g' ]),
    new Set([ 'd' ])
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'd and a -- array';

  clean();
  var layers = group.lookBfs({ roots : [ gr.d, gr.a ], onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    new Set([ 'd', 'a' ]),
    new Set([ 'g', 'b' ]),
    new Set([ 'h', 'e', 'f' ]),
    new Set([ 'i', 'c' ]),
    new Set([])
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'c', 'i', 'f', 'e', 'h', 'b', 'g', 'a', 'd' ];
  var expectedLups =
  [
    new Set([ 'd', 'a' ]),
    new Set([ 'a', 'g', 'b' ]),
    new Set([ 'h', 'e', 'f' ]),
    new Set([ 'i', 'a', 'c', 'h' ]),
    new Set([ 'f', 'h', 'b' ])
  ]
  var expectedLdws =
  [
    new Set([]),
    new Set([ 'i', 'c' ]),
    new Set([ 'h', 'e', 'f' ]),
    new Set([ 'g', 'b' ]),
    new Set([ 'd', 'a' ])
  ]
  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  gr.sys.finit();

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

  function onUp( node, it )
  {
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.level === 2 )
    it.continueNode = false;
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'a', 'f' ])
    ]
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'c', 'e', 'f' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'a', 'c', 'e', 'f' ]),
      new Set([ 'b', 'd', 'f' ])
    ]
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'a', 'e', 'f' ]),
      new Set([ 'c', 'd' ]),
      new Set([ 'b' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'e' ])
    ]
    var expectedLdws =
    [
      new Set([ 'e' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ])
    ]
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'f' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'a', 'f' ])
    ]
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'c', 'e', 'f' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'a', 'c', 'e', 'f' ]),
      new Set([ 'b', 'd', 'f' ])
    ]
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'a', 'e', 'f' ]),
      new Set([ 'c', 'd' ]),
      new Set([ 'b' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'e' ])
    ]
    var expectedLdws =
    [
      new Set([ 'e' ])
    ]
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

    var expectedLups =
    ([
      new Set([ 'f' ]),
      new Set([ 'f' ])
    ])
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'f' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'a', 'f' ])
    ]
    var expectedLdws =
    [
      new Set([ 'a', 'f' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ]
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

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'b', 'd', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'b', 'd', 'f' ];
    var expectedDws = [ 'f', 'd', 'b', 'f', 'e', 'c', 'a', 'b', 'd', 'c', 'b' ];

    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'a', 'c', 'e', 'f' ]),
      new Set([ 'b', 'd', 'f' ])
    ]
    var expectedLdws =
    [
      new Set([ 'b', 'd', 'f' ]),
      new Set([ 'a', 'c', 'e', 'f' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'b' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'e' ])
    ]
    var expectedLdws =
    [
      new Set([ 'e' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ]),
    ]
    var expectedLdws =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ]),
    ]
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

    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ])
    ]
    var expectedLdws =
    [
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ])
    ]
    var expectedLdws =
    [
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'b' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'e' ])
    ]
    var expectedLdws =
    [
      new Set([ 'e' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ])
    ]
    var expectedLdws =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ])
    ]
    var expectedLdws =
    [
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ])
    ]
    var expectedLdws =
    [
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'c', 'd', 'b', 'e', 'f', 'a' ]),
      new Set([ 'b', 'd', 'a', 'f', 'c', 'e' ]),
      new Set([ 'a', 'c', 'e', 'f', 'd', 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'b' ])
    ]

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

    var expectedLups =
    [
      new Set([ 'e' ])
    ]
    var expectedLdws =
    [
      new Set([ 'e' ])
    ]
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

    var expectedLups =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ])
    ]
    var expectedLdws =
    [
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ]),
      new Set([ 'f' ])
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 3, with onLayerUp' );

    test.close( 'fast : ' + o.fast );
  }

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
    onUp( node, it );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp2( nodes, it )
  {
    if( it.level > 4 )
    it.continueUp = false;
    onLayerUp( nodes, it );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
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
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp3( nodes, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    onLayerUp( nodes, it );
  }

  function onLayerUp4( nodes, it )
  {
    if( it.level > 0 )
    it.continueUp = false;
    onLayerUp( nodes, it );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerDown3( nodes, it )
  {
    if( !it.continueNode )
    return
    onLayerDown( nodes, it );
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
    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
      new Set([ 'c', 'd', 'b', 'c', 'e', 'f' ]),
    ];
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ]
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
    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
      new Set([ 'a', 'c', 'e', 'f' ]),
    ];
    var expectedLdws =
    [
      new Set([]),
      new Set([ 'c', 'd' ]),
      new Set([ 'b' ])
    ]
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
    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
    ];
    var expectedLdws =
    [
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ];
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
    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
    ];
    var expectedLdws =
    [
      new Set([ 'c', 'd' ]),
      new Set([ 'b' ])
    ];
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
    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
    ];
    var expectedLdws =
    [
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ]),
    ];

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
    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
    ];
    var expectedLdws =
    [
      new Set([ 'c', 'd' ]),
      new Set([ 'b' ])
    ];
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
    var expectedLups =
    [
      new Set([ 'a' ]),
      new Set([ 'b', 'd' ]),
    ];
    var expectedLdws =
    [
      new Set([ 'b', 'd' ]),
      new Set([ 'a' ])
    ];
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
    var expectedLups =
    [
      new Set([ 'b' ]),
      new Set([ 'c', 'd', 'b' ]),
    ];
    var expectedLdws =
    [
      new Set([ 'c', 'd' ]),
      new Set([ 'b' ])
    ];
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
    var expectedUpContinueUp = [ true, true, true, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true ];
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

/*

    a ↔ b
    ↓
    c

*/

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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    console.log( 'up', node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    console.log( 'down', node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookBfsRevisitingTrivial */

//

function lookBfsRepeatsRoots( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup';
  var gr = context.cycled0Scc();
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
    var gotResult = group.lookBfs
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
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b' ]),
      new Set([])
    ]
    var expectedLog =
`
up a
up c
 up b
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var gotResult = group.lookBfs
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
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b' ]),
      new Set([])
    ]
    var expectedLog =
`
up a
up c
 up b
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 1, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, true, true ];
    var expectedDownVisited = [ 1, 1, 1, 0, 0, 0 ];
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b', 'c' ]),
      new Set([ 'a', 'b' ])
    ]
    var expectedLog =
`
up a
up c
 up b
 up c
   up a
   up b
   down b
   down a
 down c
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false ];
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b', 'c' ]),
      new Set([ 'a', 'b' ])
    ]
    var expectedLog =
`
up a
up c
 up b
 up c
   up a
   up b
   down b
   down a
 down c
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'c', 'b', 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b', 'c' ]),
      new Set([ 'a', 'b' ]),
      new Set([ 'b', 'c', 'a' ])
    ]
    var expectedLog =
`
up a
up c
 up b
 up c
   up a
   up b
     up b
     up c
     up a
     down a
     down c
     down b
   down b
   down a
 down c
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n'; /* qqq : add similar checks to each similar test cases of each similar test routines */
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookBfsRepeatsRoots */

//

function lookBfsRepeatsRootsAllSiblings0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup';
  var gr = context.cycled0Scc();
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
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allSiblings : 0,
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
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b' ]),
      new Set([])
    ]
    var expectedLog =
`
up a
up c
 up b
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allSiblings : 0,
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
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b' ]),
      new Set([])
    ]
    var expectedLog =
`
up a
up c
 up b
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allSiblings : 0,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 1, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, true, true ];
    var expectedDownVisited = [ 1, 1, 1, 0, 0, 0 ];
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b', 'c' ]),
      new Set([ 'a', 'b' ])
    ]
    var expectedLog =
`
up a
up c
 up b
 up c
   up a
   up b
   down b
   down a
 down c
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 0,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false ];
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b', 'c' ]),
      new Set([ 'a', 'b' ])
    ]
    var expectedLog =
`
up a
up c
 up b
 up c
   up a
   up b
   down b
   down a
 down c
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 0,
    });

    var expectedNds = [ 'a', 'c', 'b', 'c', 'a', 'b', 'b', 'c', 'a' ];
    var expectedUps = [ 'a', 'c', 'b', 'c', 'a', 'b', 'b', 'c', 'a' ];
    var expectedDws = [ 'a', 'c', 'b', 'b', 'a', 'c', 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedResult =
    [
      new Set([ 'a', 'c' ]),
      new Set([ 'b', 'c' ]),
      new Set([ 'a', 'b' ]),
      new Set([ 'b', 'c', 'a' ])
    ]
    var expectedLog =
`
up a
up c
 up b
 up c
   up a
   up b
     up b
     up c
     up a
     down a
     down c
     down b
   down b
   down a
 down c
 down b
down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n'; /* qqq : add similar checks to each similar test cases of each similar test routines */
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookBfsRepeatsRootsAllSiblings0 */

//

function lookBfsRepeatsRootsAllSiblings1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup';
  var gr = context.cycled0Scc();
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
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allSiblings : 1,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b' ];
    var expectedDws = [ 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b' ],
      []
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allSiblings : 1,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b' ];
    var expectedDws = [ 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b' ],
      []
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allSiblings : 1,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 0, 0, 1, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, true, true, true, true ];
    var expectedDownVisited = [ 1, 1, 1, 0, 0, 0, 0, 0 ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'c' ],
      [ 'a', 'b' ]
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up c
   up a
   up b
   down b
   down a
 down c
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 1,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'c' ],
      [ 'a', 'b' ]
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up c
   up a
   up b
   down b
   down a
 down c
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 1,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'a', 'b', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'b', 'a', 'c', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'c' ],
      [ 'a', 'b' ],
      [ 'b', 'c', 'a', 'b' ]
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up c
   up a
   up b
     up b
     up c
     up a
     up b
     down b
     down a
     down c
     down b
   down b
   down a
 down c
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n'; /* qqq : add similar checks to each similar test cases of each similar test routines */
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookBfsRepeatsRootsAllSiblings1 */

//

function lookBfsRepeatsRootsAllSiblings2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup';
  var gr = context.cycled0Scc();
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
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allSiblings : 2,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'b' ];
    var expectedDws = [ 'b', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'b' ],
      []
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up b
 down b
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allSiblings : 2,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'b' ];
    var expectedDws = [ 'b', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'b' ],
      []
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up b
 down b
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allSiblings : 2,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c', 'a', 'b', 'a', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c', 'a', 'b', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'b', 'a', 'c', 'b', 'c', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, true, false, false, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, false, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0 ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'c', 'b', 'c' ],
      [ 'a', 'b', 'a', 'b' ]
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up c
 up b
 up c
   up a
   up b
   up a
   up b
   down b
   down a
   down b
   down a
 down c
 down b
 down c
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown2,
      onNode : onNode2,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 2,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c', 'a', 'b', 'a', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c', 'a', 'b', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'b', 'a', 'c', 'b', 'c', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'c', 'b', 'c' ],
      [ 'a', 'b', 'a', 'b' ]
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up c
 up b
 up c
   up a
   up b
   up a
   up b
   down b
   down a
   down b
   down a
 down c
 down b
 down c
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var gotResult = group.lookBfs
    ({
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown3,
      onNode : onNode3,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 2,
    });

    var expectedNds = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c', 'a', 'b', 'a', 'b', 'b', 'c', 'a', 'b', 'b', 'c', 'a', 'b' ];
    var expectedUps = [ 'a', 'a', 'c', 'c', 'b', 'c', 'b', 'c', 'a', 'b', 'a', 'b', 'b', 'c', 'a', 'b', 'b', 'c', 'a', 'b' ];
    var expectedDws = [ 'b', 'a', 'c', 'b', 'b', 'a', 'c', 'b', 'b', 'a', 'b', 'a', 'c', 'b', 'c', 'b', 'c', 'c', 'a', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, false, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedResult =
    [
      [ 'a', 'a', 'c', 'c' ],
      [ 'b', 'c', 'b', 'c' ],
      [ 'a', 'b', 'a', 'b' ],
      [ 'b', 'c', 'a', 'b', 'b', 'c', 'a', 'b' ]
    ]
    var expectedLog =
`
up a
up a
up c
up c
 up b
 up c
 up b
 up c
   up a
   up b
   up a
   up b
     up b
     up c
     up a
     up b
     up b
     up c
     up a
     up b
     down b
     down a
     down c
     down b
     down b
     down a
     down c
     down b
   down b
   down a
   down b
   down a
 down c
 down b
 down c
 down b
down c
down c
down a
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLog );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n'; /* qqq : add similar checks to each similar test cases of each similar test routines */
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookBfsRepeatsRootsAllSiblings1 */

//

function lookBfsJunctions( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedDws = [ 'f', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ])
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
     up f
     down f
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedDws = [ 'f', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ])
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
     up f
     down f
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'd' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'd' ];
    var expectedDws = [ 'd', 'b2', 'c1', 'f', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, false, true, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0 ];
    var expectedVisited = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f', 'c1', 'b2' ];
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g' ]),
      new Set([ 'f', 'c1', 'b2' ]),
      new Set([ 'd' ])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
   up g
     up f
     up c1
     up b2
       up d
       down d
     down b2
     down c1
     down f
   down g
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'g', 'd', 'b1', 'c1', 'g' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'g', 'd', 'b1', 'c1', 'g' ];
    var expectedDws = [ 'g', 'c1', 'b1', 'd', 'g', 'b2', 'c1', 'f', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g' ]),
      new Set([ 'f', 'c1', 'b2', 'g' ]),
      new Set([ 'd', 'b1', 'c1', 'g' ])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
   up g
     up f
     up c1
     up b2
     up g
       up d
       up b1
       up c1
       up g
       down g
       down c1
       down b1
       down d
     down g
     down b2
     down c1
     down f
   down g
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 4 )
    {
      it.continueUp = false;
    }
  }

} /* end of function lookBfsJunctions */

//

function lookBfsJunctionsAllVariants0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 0,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedDws = [ 'f', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ])
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
     up f
     down f
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 0,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f' ];
    var expectedDws = [ 'f', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ])
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
     up f
     down f
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 0,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'd' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'd' ];
    var expectedDws = [ 'd', 'b2', 'c1', 'f', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, false, true, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, true, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0 ];
    var expectedVisited = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'f', 'c1', 'b2' ];
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g' ]),
      new Set([ 'f', 'c1', 'b2' ]),
      new Set([ 'd' ])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
   up g
     up f
     up c1
     up b2
       up d
       down d
     down b2
     down c1
     down f
   down g
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 0,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'g', 'd', 'b1', 'c1', 'g' ];
    var expectedUps = [ 'a0', 'd', 'g', 'e', 'b1', 'c2', 'g', 'f', 'c1', 'b2', 'g', 'd', 'b1', 'c1', 'g' ];
    var expectedDws = [ 'g', 'c1', 'b1', 'd', 'g', 'b2', 'c1', 'f', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedResult =
    [
      new Set([ 'a0' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g' ]),
      new Set([ 'f', 'c1', 'b2', 'g' ]),
      new Set([ 'd', 'b1', 'c1', 'g' ])
    ]
    var expectedLogStr =
`
up a0
 up d
 up g
   up e
   up b1
   up c2
   up g
     up f
     up c1
     up b2
     up g
       up d
       up b1
       up c1
       up g
       down g
       down c1
       down b1
       down d
     down g
     down b2
     down c1
     down f
   down g
   down c2
   down b1
   down e
 down g
 down d
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 4 )
    {
      it.continueUp = false;
    }
  }

} /* end of function lookBfsJunctionsAllVariants0 */

//

function lookBfsJunctionsAllVariants1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 1,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedDws = [ 'f', 'c1', 'b2', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ]
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ]);
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'b2', 'c1' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up b2
   up c1
     up f
     down f
   down c1
   down b2
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 1,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedDws = [ 'f', 'c1', 'b2', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ])
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'b2', 'c1' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up b2
   up c1
     up f
     down f
   down c1
   down b2
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 1,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'd' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'd' ];
    var expectedDws = [ 'd', 'b1', 'b2', 'c2', 'c1', 'f', 'c1', 'b2', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, true, true, true, false, false, false, false, false ]
    var expectedUpVisited = [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 2, 2, 2, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, false, true, true, true, false, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ 1, 2, 2, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ];
    var expectedVisited = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g', 'b2', 'c1' ]),
      new Set([ 'f', 'c1', 'c2', 'b2', 'b1' ]),
      new Set([ 'd' ])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up g
   up b2
   up c1
     up f
     up c1
     up c2
     up b2
     up b1
       up d
       down d
     down b1
     down b2
     down c2
     down c1
     down f
   down c1
   down b2
   down g
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 1,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'g', 'd', 'b1', 'b2', 'c1', 'c2', 'g' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'g', 'd', 'b1', 'b2', 'c1', 'c2', 'g' ];
    var expectedDws = [ 'g', 'c2', 'c1', 'b2', 'b1', 'd', 'g', 'b1', 'b2', 'c2', 'c1', 'f', 'c1', 'b2', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g', 'b2', 'c1' ]),
      new Set([ 'f', 'c1', 'c2', 'b2', 'b1', 'g' ]),
      new Set([ 'd', 'b1', 'b2', 'c1', 'c2', 'g' ])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up g
   up b2
   up c1
     up f
     up c1
     up c2
     up b2
     up b1
     up g
       up d
       up b1
       up b2
       up c1
       up c2
       up g
       down g
       down c2
       down c1
       down b2
       down b1
       down d
     down g
     down b1
     down b2
     down c2
     down c1
     down f
   down c1
   down b2
   down g
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 4 )
    {
      it.continueUp = false;
    }
  }

} /* end of function lookBfsJunctionsAllVariants1 */

//

function lookBfsJunctionsAllVariants2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
  var group = gr.sys.nodesGroup();

/*
qqq : replace all [ gr.a0, gr.a0, gr.a1 ] -> [ gr.a0, gr.a0, gr.a1, gr.a1 ]
*/

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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 2,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedDws = [ 'f', 'c1', 'b2', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ]);
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'b2', 'c1' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up b2
   up c1
     up f
     down f
   down c1
   down b2
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 2,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedDws = [ 'f', 'c1', 'b2', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ])
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'b2', 'c1' ]),
      new Set([ 'f' ]),
      new Set([])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up b2
   up c1
     up f
     down f
   down c1
   down b2
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 2,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'd' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'd' ];
    var expectedDws = [ 'd', 'b1', 'b2', 'c2', 'c1', 'f', 'c1', 'b2', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, true, true, true, false, false, false, false, false ];
    var expectedUpVisited = [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 2, 2, 2, 1 ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, false, true, true, true, false, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ 1, 2, 2, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ];
    var expectedVisited = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'b2', 'c1', 'f' ];
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g', 'b2', 'c1' ]),
      new Set([ 'f', 'c1', 'c2', 'b2', 'b1' ]),
      new Set([ 'd' ])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up g
   up b2
   up c1
     up f
     up c1
     up c2
     up b2
     up b1
       up d
       down d
     down b1
     down b2
     down c2
     down c1
     down f
   down c1
   down b2
   down g
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 2,
    }
    var gotResult = group.lookBfs( o2 );

    var expectedNds = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'g', 'd', 'b1', 'b2', 'c1', 'c2', 'g' ];
    var expectedUps = [ 'a0', 'a1', 'd', 'g', 'e', 'b1', 'c2', 'g', 'b2', 'c1', 'f', 'c1', 'c2', 'b2', 'b1', 'g', 'd', 'b1', 'b2', 'c1', 'c2', 'g' ];
    var expectedDws = [ 'g', 'c2', 'c1', 'b2', 'b1', 'd', 'g', 'b1', 'b2', 'c2', 'c1', 'f', 'c1', 'b2', 'g', 'c2', 'b1', 'e', 'g', 'd', 'a1', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, false, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedResult =
    [
      new Set([ 'a0', 'a1' ]),
      new Set([ 'd', 'g' ]),
      new Set([ 'e', 'b1', 'c2', 'g', 'b2', 'c1' ]),
      new Set([ 'f', 'c1', 'c2', 'b2', 'b1', 'g' ]),
      new Set([ 'd', 'b1', 'b2', 'c1', 'c2', 'g' ])
    ]
    var expectedLogStr =
`
up a0
up a1
 up d
 up g
   up e
   up b1
   up c2
   up g
   up b2
   up c1
     up f
     up c1
     up c2
     up b2
     up b1
     up g
       up d
       up b1
       up b2
       up c1
       up c2
       up g
       down g
       down c2
       down c1
       down b2
       down b1
       down d
     down g
     down b1
     down b2
     down c2
     down c1
     down f
   down c1
   down b2
   down g
   down c2
   down b1
   down e
 down g
 down d
down a1
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( gotResult.map( ( nodes ) => group.nodesToNames( nodes ) ), expectedResult );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 4 )
    {
      it.continueUp = false;
    }
  }

} /* end of function lookBfsJunctionsAllVariants2 */

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

  function onUp( node, it )
  {
    ups.push( node );
  }

  function onDown( node, it )
  {
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  logger.log( group.exportString({ nodes : gr.nodes }) );

  /* */

  test.case = 'all';

  clean();
  group.lookDfs({ roots : gr.nodes, onUp : onUp, onDown : onDown, onNode : onNode });

  var expectedUps = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f', 'd', 'g', 'j' ];
  var expectedDws = [ 'c', 'f', 'i', 'h', 'e', 'b', 'a', 'g', 'd', 'j' ];

  test.identical( group.nodesToNames( ups ), expectedUps );
  test.identical( group.nodesToNames( dws ), expectedDws );

  /* */

  test.case = 'only a';

  clean();
  group.lookDfs({ roots : gr.a, onUp : onUp, onDown : onDown, onNode : onNode });

  var expectedUps = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var expectedDws = [ 'c', 'f', 'i', 'h', 'e', 'b', 'a' ];

  test.identical( group.nodesToNames( ups ), expectedUps );
  test.identical( group.nodesToNames( dws ), expectedDws );

  /* */

  test.case = 'only d';

  clean();
  group.lookDfs({ roots : gr.d, onUp : onUp, onDown : onDown, onNode : onNode });

  var expectedUps = [ 'd', 'a', 'b', 'e', 'c', 'h', 'i', 'f', 'g' ];
  var expectedDws = [ 'c', 'f', 'i', 'h', 'e', 'b', 'a', 'g', 'd' ];

  test.identical( group.nodesToNames( ups ), expectedUps );
  test.identical( group.nodesToNames( dws ), expectedDws );

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

  function onUp( node, it )
  {
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.level === 2 )
    it.continueNode = false;
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.level > 7 )
    it.continueUp = false;
    ups.push( node );
  }

  function onDown( node, it )
  {
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function handleUp2( node, it )
  {
    if( it.level > 0 )
    it.continueUp = false;
    ups.push( node );
  }

  function handleDown2( node, it )
  {
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

 /*

     a ↔ b
     ↓
     c

 */

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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    console.log( 'up', node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    console.log( 'down', node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookDfsRevisitingTrivial */

//

/*
qqq : use graph cycled0Scc in look*RepeatsRoots* tests
*/

function lookDfsRepeatsRoots( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

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
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];
    var expectedVisited = new Set([ 'a', 'b', 'c' ]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true ];
    var expectedUpVisited = [ false, false, true, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'b', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'b', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
     up b
     down b
     up c
     down c
   down a
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
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
    logStr = '\n';
  }

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookDfsRepeatsRoots */

//

function lookDfsRepeatsRootsAllSiblings0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

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
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allSiblings : 0,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c' ];
    var expectedUps = [ 'a', 'b', 'c' ];
    var expectedDws = [ 'b', 'c', 'a' ];
    var expectedUpContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownContinueNode = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedDownVisited = [ false, false, false ];
    var expectedVisited = new Set([ 'a', 'b', 'c' ]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allSiblings : 0,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allSiblings : 0,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true ];
    var expectedUpVisited = [ false, false, true, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 0,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 0,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'b', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'b', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
     up b
     down b
     up c
     down c
   down a
 down b
 up c
 down c
down a
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
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
    logStr = '\n';
  }

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookDfsRepeatsRootsAllSiblings0 */

//

function lookDfsRepeatsRootsAllSiblings1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

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
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allSiblings : 1,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, false, false, false ];
    var expectedDownVisited = [ false, false, false, true, true, true ];
    var expectedVisited = new Set([ 'a', 'b', 'c' ]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
up a
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allSiblings : 1,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, true, false ];
    var expectedUpVisited = [ false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, false, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
up a
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allSiblings : 1,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, false, true, false ];
    var expectedUpVisited = [ false, false, true, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, false ];
    var expectedDownVisited = [ true, false, false, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up a
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 1,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'a', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up a
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 1,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'b', 'c', 'c', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'b', 'c', 'c', 'a', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, false, true, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, false, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
     up b
     down b
     up c
     down c
   down a
 down b
 up c
 down c
down a
up a
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
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
    logStr = '\n';
  }

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookDfsRepeatsRootsAllSiblings1 */

//

function lookDfsRepeatsRootsAllSiblings2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

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
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allSiblings : 2,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, false, false, false ];
    var expectedDownVisited = [ false, false, false, true, true, true ];
    var expectedVisited = new Set([ 'a', 'b', 'c' ]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
up a
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allSiblings : 2,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'c', 'a', 'b', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'c', 'a', 'b', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a
 up b
 down b
 up c
 down c
down a
up a
 up b
 down b
 up c
 down c
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allSiblings : 2,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, false, true, true, true, false, true, true, true ];
    var expectedUpVisited = [ false, false, true, false, false, false, true, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( group.nodesToNames( o2.visitedContainer ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-2';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 2,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'c', 'a', 'b', 'a', 'c', 'c', 'c' ];
    var expectedDws = [ 'a', 'b', 'c', 'a', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up a
 up b
   up a
   down a
 down b
 up c
 down c
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3, levels : 0-3';

    clean();
    var o2 =
    {
      roots : [ gr.a, gr.a, gr.c, gr.c ],
      onUp : onUp3,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allSiblings : 2,
    }
    var gotResult = group.lookDfs( o2 );

    var expectedNds = [ 'a', 'b', 'a', 'b', 'c', 'c', 'a', 'b', 'a', 'b', 'c', 'c', 'c', 'c' ];
    var expectedUps = [ 'a', 'b', 'a', 'b', 'c', 'c', 'a', 'b', 'a', 'b', 'c', 'c', 'c', 'c' ];
    var expectedDws = [ 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'c', 'c' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, false, false, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a
 up b
   up a
     up b
     down b
     up c
     down c
   down a
 down b
 up c
 down c
down a
up a
 up b
   up a
     up b
     down b
     up c
     down c
   down a
 down b
 up c
 down c
down a
up c
down c
up c
down c
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
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
    logStr = '\n';
  }

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    onUp( node, it );
    if( it.level >= 2 )
    it.continueUp = false;
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    onUp( node, it );
    if( it.level >= 3 )
    it.continueUp = false;
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookDfsRepeatsRootsAllSiblings2 */

//

function lookDfsJunctions( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'b2', 'c2', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([])
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
     up b2
     down b2
   down c2
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, false, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, true, false, false, true, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'c1', 'b1', 'b2', 'c2', 'b1', 'c2', 'g', 'g', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
     up b1
       up c1
       down c1
     down b1
     up c2
       up b2
       down b2
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
     down g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctions */

//

function lookDfsJunctionsAllVariants0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'b2', 'c2', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([])
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
     up b2
     down b2
   down c2
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, false, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, true, false, false, true, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'c1', 'b1', 'b2', 'c2', 'b1', 'c2', 'g', 'g', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
     up b1
       up c1
       down c1
     down b1
     up c2
       up b2
       down b2
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
     down g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants0 */

//

function lookDfsJunctionsAllVariants0AllSiblings0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 0,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 0,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'b2', 'c2', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([])
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
     up b2
     down b2
   down c2
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 0,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, false, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, true, false, false, true, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 0,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'c1', 'b1', 'b2', 'c2', 'b1', 'c2', 'g', 'g', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
     up b1
       up c1
       down c1
     down b1
     up c2
       up b2
       down b2
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
     down g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants0AllSiblings0 */

//

function lookDfsJunctionsAllVariants0AllSiblings1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 0,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'a0' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'a0' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'c2', 'g', 'a0', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, true, false, false, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
   down c2
 down g
down a0
up a0
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 0,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2', 'a0' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2', 'a0' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'b2', 'c2', 'g', 'a0', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([])
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
     up b2
     down b2
   down c2
 down g
down a0
up a0
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

   test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 0,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'a0' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'a0' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'g', 'g', 'a0', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, false, false, true, true, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, true, false ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, true, false, false, true, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
   down g
 down g
down a0
up a0
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 0,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g', 'a0' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g', 'a0' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'c1', 'b1', 'b2', 'c2', 'b1', 'c2', 'g', 'g', 'g', 'g', 'a0', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
     up b1
       up c1
       down c1
     down b1
     up c2
       up b2
       down b2
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
     down g
   down g
 down g
down a0
up a0
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants0AllSiblings1 */

//

function lookDfsJunctionsAllVariants0AllSiblings2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 0,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'a0' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'a0' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'c2', 'g', 'a0', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, true, false, false, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
   down c2
 down g
down a0
up a0
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 0,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2', 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2', 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'b1', 'b2', 'c2', 'g', 'a0', 'f', 'e', 'd', 'c1', 'b1', 'b2', 'c2', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([])
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
     up b2
     down b2
   down c2
 down g
down a0
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
   down b1
   up c2
     up b2
     down b2
   down c2
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

   test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 0,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'g', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, false, true, true, true, true, false, true, true, true, false, true, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, false, false, true, true, false, false, false, false, true, false, false, false, true, false, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, true, false, true, true, true, false, true, true, false, true, true, false, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, false, false, true, false, false, true, false, false, true, false, false, false, true, false, false, true, false, false, true, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
   down g
 down g
down a0
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 0,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'c2', 'b2', 'c1', 'g', 'b1', 'c1', 'c2', 'b2', 'g', 'b1', 'c2', 'g' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'c1', 'b1', 'b2', 'c2', 'b1', 'c2', 'g', 'g', 'g', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'c1', 'b1', 'c1', 'b2', 'c2', 'c1', 'b1', 'b2', 'c2', 'b1', 'c2', 'g', 'g', 'g', 'g', 'a0' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true, false, true, true, true, false, true, true, false, true, true, false, true, false, true, false, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
     up b1
       up c1
       down c1
     down b1
     up c2
       up b2
       down b2
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
     down g
   down g
 down g
down a0
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
     down c1
   down b1
   up c2
     up b2
       up c1
       down c1
     down b2
   down c2
   up g
     up b1
       up c1
       down c1
     down b1
     up c2
       up b2
       down b2
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
     down g
   down g
 down g
down a0
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants0AllSiblings2 */

//

function lookDfsJunctionsAllVariants1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, true, true, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, true, false, true, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, false, false, true, true, false, true, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, false, false, true, true, false, false, false, true, false, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
/*
qqq : remake each expectedLogStr with prefix "--"
ask for more details
*/
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
     down b2
     up c1
     down c1
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants1 */

//

function lookDfsJunctionsAllVariants1AllSiblings0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 1,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 1,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, true, true, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, true, false, true, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 1,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, false, false, true, true, false, true, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, false, false, true, true, false, false, false, true, false, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 1,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
     down b2
     up c1
     down c1
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants1AllSiblings0 */

//

function lookDfsJunctionsAllVariants1AllSiblings1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 1,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 1,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, true, true, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, true, false, true, false, false, true, true, false, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 1,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, false, false, true, true, false, true, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, false, true, true, false, false ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, false, false, true, true, false, false, false, true, false, false, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 1,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
     down b2
     up c1
     down c1
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants1AllSiblings1 */

//

function lookDfsJunctionsAllVariants1AllSiblings2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 1,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 1,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, true, true, false, false, false, true, true, true, true, true, true, true, false, true, true, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, true, false, true, false, false, true, true, true, true, true, true, false, true, true, false, true, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
up d
 up e
   up f
   down f
 down e
down d
up g
 up b1
   up c1
   down c1
   up c2
   down c2
 down b1
 up c2
   up b2
   down b2
   up b1
   down b1
 down c2
 up b2
 down b2
 up c1
 down c1
down g
down a0
up a0
up d
 up e
   up f
   down f
 down e
down d
up g
 up b1
   up c1
   down c1
   up c2
   down c2
 down b1
 up c2
   up b2
   down b2
   up b1
   down b1
 down c2
 up b2
 down b2
 up c1
 down c1
down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 1,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, false, false, false, true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, false, false, true, true, false, true, false, false, false, false, false, false, true, false, false, false, true, true, false, false, false, true, true, false, true, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ]
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, false, true, true, false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, false, false, true, true, false, false, false, true, false, false, false, false, true, false, false, false, true, true, false, false, false, true, true, false, false, false, true, false, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 1,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'c2', 'b2', 'c1', 'c2', 'b1', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, true, true, true, true, false, true, true, true, false, false, false, true, true, false, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, true, true, true, false, false, true, false, true, false, false, true, false, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
     down b2
     up c1
     down c1
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
     down b2
     up c1
     down c1
   down g
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants1AllSiblings2 */

//

function lookDfsJunctionsAllVariants2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a0', 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ]
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp =  [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants2 */

//

function lookDfsJunctionsAllVariants2AllSiblings0( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 2,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 2,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a0', 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ]
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 2,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 2,
      allSiblings : 0,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp =  [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants2AllSiblings0 */

//

function lookDfsJunctionsAllVariants2AllSiblings1( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 2,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 2,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a0', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a0', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a0', 'a0', 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ]
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a0
up a0
down a0
up a1
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 2,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a0
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 2,
      allSiblings : 1,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp =  [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a0
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants2AllSiblings1 */

//

function lookDfsJunctionsAllVariants2AllSiblings2( test )
{
  let context = this;
  let ups = [];
  let dws = [];
  let nds = [];
  let upContinueNode = [];
  let downContinueNode = [];
  let upContinueUp = [];
  let downContinueUp = [];
  let upVisited = [];
  let downVisited = [];
  let logStr = '';

  test.description = 'setup cycledJunctions5';
  var gr = context.cycledJunctions5();
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
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
      allVariants : 2,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'c1', 'a0', 'a1' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'c2', 'b2', 'c1', 'g', 'a0', 'a0', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, false, false, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, true, true, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, false, true, false, false, false, true, true, false, false ];
    var expectedDownVisited = [ false, false, false, false, true, false, true, true, true, false, false, true, true ];
    var expectedVisited = new Set([ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2', 'a1' ]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
   down c2
   up b2
   down b2
   up c1
   down c1
 down g
down a0
up a0
down a0
up a1
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
      allVariants : 2,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a0', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'a1', 'd', 'e', 'f', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a0', 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a0', 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a0
up a0
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
     down f
   down e
 down d
 up g
   up b1
     up c1
     down c1
     up c2
     down c2
   down b1
   up c2
     up b2
     down b2
     up b1
     down b1
   down c2
   up b2
     up c1
     down c1
     up c2
     down c2
   down b2
   up c1
     up b1
     down b1
     up b2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
      allVariants : 2,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false, true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false ];
    var expectedVisited = [];
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.case = 'revisiting : 3';

    clean();
    var o2 =
    {
      roots : [ gr.a0, gr.a0, gr.a1 ],
      onUp : onUp2,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 3,
      allVariants : 2,
      allSiblings : 2,
    }
    group.lookDfs( o2 );

    var expectedNds = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedUps = [ 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a0', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'a1', 'd', 'e', 'f', 'd', 'g', 'b1', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'g', 'b1', 'c1', 'c2', 'c2', 'b2', 'b1', 'g', 'b1', 'c2', 'g', 'b2', 'c1', 'b2', 'c1', 'c2', 'c1', 'b1', 'b2', 'b2', 'c1', 'b1', 'b2', 'c2', 'b2', 'b1', 'c1', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a0', 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'b1', 'c2', 'g', 'b2', 'c1', 'g', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a1' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp =  [ true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true, false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = null;
    var expectedLogStr =
`
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a0
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a0
up a1
 up d
   up e
     up f
       up d
       down d
     down f
   down e
 down d
 up g
   up b1
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b1
   up c2
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
   down c2
   up g
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
     up g
       up b1
       down b1
       up c2
       down c2
       up g
       down g
       up b2
       down b2
       up c1
       down c1
     down g
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
   down g
   up b2
     up c1
       up b1
       down b1
       up b2
       down b2
     down c1
     up c2
       up b2
       down b2
       up b1
       down b1
     down c2
   down b2
   up c1
     up b1
       up c1
       down c1
       up c2
       down c2
     down b1
     up b2
       up c1
       down c1
       up c2
       down c2
     down b2
   down c1
 down g
down a1
`

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer, expectedVisited );
    test.equivalent( logStr, expectedLogStr );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

  function log( srcStr )
  {
    _.assert( arguments.length === 1 );
    logStr += srcStr + '\n';
    /* logger.log( srcStr ); */
  }

  function clean()
  {
    logStr = '\n';
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' up ' + node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 4 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown( node, it )
  {
    log( _.strDup( '  ', it.level ) + ' down ' + node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

} /* end of function lookDfsJunctionsAllVariants2AllSiblings2 */

lookDfsJunctionsAllVariants2AllSiblings2.timeOut = 30000;

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

  function onUp( node, it )
  {
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.level === 2 )
    it.continueNode = false;
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function onUp( node, it )
  {
    if( it.level > 7 )
    it.continueUp = false;
    ups.push( node );
  }

  function onDown( node, it )
  {
    dws.push( node );
  }

  function onNode( node, it )
  {
    nds.push( node );
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

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( node );
  }

  function onDown( node, it )
  {
    dws.push( node );
  }

  function handleUp2( node, it )
  {
    if( it.level > 0 )
    it.continueUp = false;
    ups.push( node );
  }

  function handleDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode( node, it )
  {
    nds.push( node );
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
  let upIndex = [];
  let downIndex = [];
  let upLevel = [];
  let downLevel = [];

  /* qqq :
    add all this checks into lookBfsRevisitingTrivial
    add all this checks into lookDfsRevisitingTrivial
  */

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
    var expectedDownContinueNode = [ true, true, true ];
    var expectedUpContinueUp = [ true, true, true ];
    var expectedDownContinueUp = [ true, true, true ];
    var expectedUpVisited = [ false, false, false ];
    var expectedDownVisited = [ false, false, false ];
    var expectedUpLevel = [ 0, 0, 1 ];
    var expectedDownLevel = [ 1, 0, 0 ];
    var expectedUpIndex = [ 0, 1, 0 ];
    var expectedDownIndex = [ 0, 0, 1 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downVisited, expectedDownVisited );
    test.identical( upLevel, expectedUpLevel );
    test.identical( downLevel, expectedDownLevel );
    test.identical( upIndex, expectedUpIndex );
    test.identical( downIndex, expectedDownIndex );

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
    var expectedDownContinueNode = [ true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false ];
    var expectedDownVisited = [ false, false, false, false ];
    var expectedUpLevel = [ 0, 0, 1, 1 ];
    var expectedDownLevel = [ 1, 1, 0, 0 ];
    var expectedUpIndex = [ 0, 1, 0, 1 ];
    var expectedDownIndex = [ 0, 1, 0, 1 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downVisited, expectedDownVisited );
    test.identical( upLevel, expectedUpLevel );
    test.identical( downLevel, expectedDownLevel );
    test.identical( upIndex, expectedUpIndex );
    test.identical( downIndex, expectedDownIndex );

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
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, true ];
    var expectedDownVisited = [ true, false, false, false, false ];
    var expectedUpLevel = [ 0, 0, 1, 1, 2 ];
    var expectedDownLevel = [ 2, 1, 1, 0, 0 ];
    var expectedUpIndex = [ 0, 1, 0, 1, 0 ];
    var expectedDownIndex = [ 0, 0, 1, 0, 1 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downVisited, expectedDownVisited );
    test.identical( upLevel, expectedUpLevel );
    test.identical( downLevel, expectedDownLevel );
    test.identical( upIndex, expectedUpIndex );
    test.identical( downIndex, expectedDownIndex );

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
    var expectedDownContinueNode = [ true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, false ];
    var expectedDownContinueUp = [ false, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false ];
    var expectedDownVisited = [ false, false, false, false, false ];
    var expectedUpLevel = [ 0, 0, 1, 1, 2 ];
    var expectedDownLevel = [ 2, 1, 1, 0, 0 ];
    var expectedUpIndex = [ 0, 1, 0, 1, 0 ];
    var expectedDownIndex = [ 0, 0, 1, 0, 1 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downVisited, expectedDownVisited );
    test.identical( upLevel, expectedUpLevel );
    test.identical( downLevel, expectedDownLevel );
    test.identical( upIndex, expectedUpIndex );
    test.identical( downIndex, expectedDownIndex );

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
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, false ];
    var expectedDownContinueUp = [ false, false, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedUpLevel = [ 0, 0, 1, 1, 2, 3, 3 ];
    var expectedDownLevel = [ 3, 3, 2, 1, 1, 0, 0 ];
    var expectedUpIndex = [ 0, 1, 0, 1, 0, 0, 1 ];
    var expectedDownIndex = [ 0, 1, 0, 0, 1, 0, 1 ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downVisited, expectedDownVisited );
    test.identical( upLevel, expectedUpLevel );
    test.identical( downLevel, expectedDownLevel );
    test.identical( upIndex, expectedUpIndex );
    test.identical( downIndex, expectedDownIndex );

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
    upIndex = [];
    downIndex = [];
    upLevel = [];
    downLevel = [];
  }

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    logger.log( _.strDup( '  ', it.level ), 'up', node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    upIndex.push( it.index );
    upLevel.push( it.level );
    ups.push( node );
  }

  function onDown( node, it )
  {
    logger.log( _.strDup( '  ', it.level ), 'down', node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    downIndex.push( it.index );
    downLevel.push( it.level );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    logger.log( _.strDup( '  ', it.level ), 'up', node.name );
    if( it.level >= 3 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown3( node, it )
  {
    logger.log( _.strDup( '  ', it.level ), 'down', node.name );
    onDown( node, it );
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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
  }

  function onDown( node, it )
  {
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
  }

  function onNode2( node, it )
  {
    nds.push( node );
  }

  function onUp2( node, it )
  {
    if( it.level >= 2 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown2( node, it )
  {
    onDown( node, it );
  }

  function onNode3( node, it )
  {
    nds.push( node );
  }

  function onUp3( node, it )
  {
    if( it.level >= 3 )
    it.continueUp = false;
    onUp( node, it );
  }

  function onDown3( node, it )
  {
    onDown( node, it );
  }

} /* end of lookCfsRepeatsRoots */

//

function lookCfsJunctions( test )
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
  var upLevel = [];
  var downLevel = [];

/*

     ↗ c2 → b2
   g
   ↑ ↘ b1 → c1
   a
   ↓
   d → e
     ↖ ↓
       f

*/

  test.description = 'setup cycledJunctions4';
  var gr = context.cycledJunctions4();
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
    var o2 =
    {
      roots : [ gr.a ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 0,
    }
    group.lookCfs( o2 );

    var expectedNds = [ 'a', 'd', 'g', 'e', 'f', 'b1', 'c2' ];
    var expectedUps = [ 'a', 'd', 'g', 'e', 'f', 'b1', 'c2' ];
    var expectedDws = [ 'f', 'e', 'd', 'b1', 'c2', 'g', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false ];
    var expectedVisited = new Set([ 'a', 'd', 'e', 'f', 'g', 'b1', 'c1', 'b2', 'c2' ]);

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );

    /* - */

    test.case = 'revisiting : 1';

    clean();
    var o2 =
    {
      roots : [ gr.a ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 1,
    }
    group.lookCfs( o2 );

    var expectedNds = [ 'a', 'd', 'g', 'e', 'f', 'b1', 'c2', 'b2', 'c1', 'c1', 'c2', 'b2', 'b1', 'c1', 'c2', 'b1', 'b2' ];
    var expectedUps = [ 'a', 'd', 'g', 'e', 'f', 'b1', 'c2', 'b2', 'c1', 'c1', 'c2', 'b2', 'b1', 'c1', 'c2', 'b1', 'b2' ];
    var expectedDws = [ 'f', 'e', 'd', 'c1', 'c2', 'b1', 'b2', 'b1', 'c2', 'c1', 'c2', 'b2', 'b1', 'b2', 'c1', 'g', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownVisited = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
    var expectedVisited = new Set([]);

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );

    /* - */

    test.case = 'revisiting : 2';

    clean();
    var o2 =
    {
      roots : [ gr.a ],
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
      revisiting : 2,
    }
    group.lookCfs( o2 );

    var expectedNds = [ 'a', 'd', 'g', 'e', 'f', 'd', 'b1', 'c2', 'b2', 'c1', 'c1', 'c2', 'b1', 'b2', 'b2', 'b1', 'b2', 'b1', 'c1', 'c2', 'c1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b2', 'b1', 'b1', 'b2', 'c1', 'c2', 'c1', 'c2' ];
    var expectedUps = [ 'a', 'd', 'g', 'e', 'f', 'd', 'b1', 'c2', 'b2', 'c1', 'c1', 'c2', 'b1', 'b2', 'b2', 'b1', 'b2', 'b1', 'c1', 'c2', 'c1', 'c2', 'c1', 'c2', 'b1', 'b2', 'b2', 'b1', 'b1', 'b2', 'c1', 'c2', 'c1', 'c2' ];
    var expectedDws = [ 'd', 'f', 'e', 'd', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c2', 'b1', 'b2', 'c1', 'b2', 'b1', 'c2', 'b2', 'c1', 'c2', 'b1', 'c1', 'c2', 'b2', 'c1', 'g', 'a' ];
    var expectedUpContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedUpContinueUp = [ true, true, true, true, true, false, true, true, true, true, true, true, false, false, false, false, true, true, false, false, false, false, true, true, false, false, false, false, true, true, false, false, false, false ];
    var expectedUpVisited = [ false, false, false, false, false, true, false, false, false, false, false, false, true, true, true, true, false, false, true, true, true, true, false, false, true, true, true, true, false, false, true, true, true, true ];
    var expectedDownContinueNode = [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ];
    var expectedDownContinueUp = [ false, true, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, false, false, true, false, false, true, true, true, true ];
    var expectedDownVisited = [ true, false, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, false, true, true, false, false, false, false ];
    var expectedVisited = [];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( upContinueNode, expectedUpContinueNode );
    test.identical( upContinueUp, expectedUpContinueUp );
    test.identical( upVisited, expectedUpVisited );
    test.identical( downContinueNode, expectedDownContinueNode );
    test.identical( downContinueUp, expectedDownContinueUp );
    test.identical( downVisited, expectedDownVisited );
    test.identical( o2.visitedContainer.map( ( node ) => group.nodeToName( node ) ).original, expectedVisited );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

  /* - */

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

  function onNode( node, it )
  {
    nds.push( node );
  }

  function onUp( node, it )
  {
    logger.log( _.strDup( '  ', it.level ), 'up', node.name );
    upContinueNode.push( it.continueNode );
    upContinueUp.push( it.continueUp );
    upVisited.push( it.visited );
    ups.push( node );
    upLevel.push( it.level );
  }

  function onDown( node, it )
  {
    logger.log( _.strDup( '  ', it.level ), 'down', node.name );
    downContinueNode.push( it.continueNode );
    downContinueUp.push( it.continueUp );
    downVisited.push( it.visited );
    dws.push( node );
    downLevel.push( it.level );
  }

} /* end of function lookCfsJunctions */

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
  logger.log( 'DAG' )
  logger.log( group.nodesInfoExport( gr.nodes ) );

  var ordering = group.dagTopSortDfs( gr.nodes );
  logger.log( 'Ordering' )
  logger.log( group.nodesInfoExport( ordering ) );

  test.description = 'trivial';
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
  logger.log( group.exportString({ nodes : gr.nodes }) );
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
  logger.log( group.exportString({ nodes : gr.nodes }) );

  /* */

  test.description = 'all';
  var layers = group.topSortLeastDegreeBfs( gr.nodes );
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

  test.description = 'explicit all';
  var group = gr.sys.nodesGroup();
  logger.log( group.exportString({ nodes : gr.nodes }) );
  var expected = [ 'j', 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var got = group.topSortCycledSourceBasedFastBfs( gr.nodes );
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

function topSortCycledSourceBasedPrecise( test )
{
  let context = this;

  /* - */

  test.case = 'cycled1Scc';
  var gr = context.cycled1Scc();

  /* */

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise( gr.nodes );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'none';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise( [] );
  var expected = [];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'several';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise( [ ... gr.nodes, ... gr.nodes ] );
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
  var got = group.topSortCycledSourceBasedPrecise( gr.nodes );
  var expected = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycledAsymetricChi';

  var gr = context.cycledAsymetricChi();

  test.description = 'all';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise( gr.nodes );
  // var expected = [ 'a', 'd', 'e', 'b', 'f', 'c', 'g', 'h', 'k', 'j', 'i', 'l', 'm' ];
  // var expected = [ 'a', 'b', 'd', 'e', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'm', 'j' ];
  var expected = [ 'd', 'e', 'b', 'a', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'm', 'j' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  test.description = 'rootsToAllReachable a';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise( group.rootsToAllReachable( gr.a ) );
  // var expected = [ 'a', 'b', 'c', 'g', 'h', 'k', 'j', 'i', 'l', 'm' ];
  // var expected = [ 'a', 'b', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  // var expected = [ 'a', 'b', 'c', 'g', 'h', 'k', 'i', 'l', 'm', 'j' ]
  var expected = [ 'b', 'a', 'c', 'g', 'h', 'k', 'i', 'l', 'm', 'j' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycled4Scc';

  var gr = context.cycled4Scc();

  /* */

  test.description = 'explicit all';
  var group = gr.sys.nodesGroup();
  logger.log( group.exportString({ nodes : gr.nodes }) );
  // var expected = [ 'j', 'd', 'g', 'e', 'a', 'c', 'b', 'i', 'f', 'h' ];
  var expected = [ 'j', 'd', 'g', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var got = group.topSortCycledSourceBasedPrecise( gr.nodes );
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

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

  /* */

  test.description = 'not j';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  var expected = [ 'd', 'g', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'not j, not d';
  var group = gr.sys.nodesGroup();
  var got = group.topSortCycledSourceBasedPrecise([ gr.a, gr.b, gr.c, gr.e, gr.f, gr.g, gr.h, gr.i ]);
  // var expected = [ 'g', 'e', 'a', 'c', 'b', 'i', 'h', 'f' ];
  // var expected = [ 'e', 'a', 'c', 'b', 'g', 'h', 'i', 'f' ];
  var expected = [ 'g', 'e', 'a', 'c', 'b', 'h', 'i', 'f' ];
  test.identical( group.nodesToNames( got ), expected );

  /* */

  test.description = 'c, e';
  var group = gr.sys.nodesGroup();
  test.shouldThrowErrorSync( () => group.topSortCycledSourceBasedPrecise([ gr.c, gr.e ]) );
  group.finit();

  gr.sys.finit();

  /* - */
}

//

function topSortCycledSourceBasedPreciseJunction( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctions5';
  var gr = context.cycledJunctions5();

  /* */

  test.description = 'direct';
  var group = gr.sys.nodesGroup();
  // var expected = [ 'a1', 'a0', 'd', 'e', 'f', 'g', 'b2', 'b1', 'c1', 'c2' ];
  var expected = [ 'a1', 'a0', 'd', 'g', 'e', 'f', 'b2', 'c1', 'c2', 'b1' ];
  var got = group.topSortCycledSourceBasedPrecise( gr.nodes );
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

  test.description = 'reverse';
  var group = gr.sys.nodesGroup();
  // var expected = [ 'a0', 'a1', 'f', 'd', 'e', 'g', 'c1', 'c2', 'b1', 'b2' ];
  var expected = [ 'a0', 'a1', 'd', 'g', 'e', 'f', 'c1', 'b1', 'b2', 'c2' ];
  var got = group.topSortCycledSourceBasedPrecise( gr.nodes.slice().reverse() );
  test.identical( group.nodesToNames( got ), expected );
  group.finit();

  /* */

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
  test.identical( gr.nodes.length, 8 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

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
  test.identical( gr.nodes.length, 8 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

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
  test.identical( gr.nodes.length, 8 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

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
  test.identical( gr.nodes.length, 8 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

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
  test.identical( gr.nodes.length, 8 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

  test.description = 'explicit';
  var layers = group.nodesConnectedLayersDfs( gr.nodes );
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

  test.description = 'explicit all';
  var group = gr.sys.nodesGroup();
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
  test.identical( gr.nodes.length, 10 );
  logger.log( group.exportString({ nodes : gr.nodes }) );

  var layers = group.nodesStronglyConnectedLayersDfs( gr.nodes );
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

function nodesStronglyConnectedCollectionDfs( test )
{
  let context = this;

  /* - */

  test.case = 'cycled1Scc';
  var gr = context.cycled1Scc();

  /* */

  var group = gr.sys.nodesGroup({});

  logger.log( 'Original' );
  logger.log( group.exportString({ nodes : gr.nodes }) );

  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  logger.log( 'Strongly connected tree :\n' + collection2.exportString() );
  var originalNodesNames = collection2.nodes.map( ( node ) => group.nodesToNames( node.originalNodes ).toArray().original ).toArray().original;
  var expected = [ [ 'c' ], [ 'a', 'b' ] ];
  test.identical( originalNodesNames, expected );

  var outNodes = collection2.nodes.map( ( node ) => collection2.group.nodesToNames( node.outNodes ).toArray().original ).toArray().original;
  var expected = [ [], [ 'c' ] ];
  test.identical( outNodes, expected );

  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
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
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );
  group.finit();

  /* */

  test.description = '[ a, h, g, f, e, d, c, b ]';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs([ gr.a, gr.h, gr.g, gr.f, gr.e, gr.d, gr.c, gr.b ]);
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'h+f+g : ', 'e : h+f+g', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all a';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( group.rootsToAllReachable( gr.a ) );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all c';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( group.rootsToAllReachable( gr.c ) );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'c+a+b : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all d';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( group.rootsToAllReachable( gr.d ) );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e' ];
  test.identical( outNodes, expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycled4Scc'
  var gr = context.cycled4Scc();

  /* */

  test.description = 'all, explicit';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'j : ', 'f : ', 'i+h : f', 'g : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
  test.identical( outNodes, expected );
  logger.log( 'Tree' );
  logger.log( collection2.exportString() );

  /* */

  test.description = 'connected';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.connectedNodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = collection2.nodes.map( ( dnode ) => collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f : ', 'i+h : f', 'g : i+h', 'a+b+e+c : f.i+h', 'd : a+b+e+c.g' ];
  test.identical( outNodes, expected );
  logger.log( 'Tree' );
  logger.log( collection2.exportString() );

  /* */

  test.description = 'no j, no f';
  var group = gr.sys.nodesGroup();
  test.shouldThrowErrorSync( () =>
  {
    var collection2 = group.nodesStronglyConnectedCollectionDfs([ gr.a, gr.b, gr.c, gr.d, gr.e, gr.g, gr.h, gr.i ]);
  });

  /* */

  gr.sys.finit();

  /* - */

}

//

function nodesStronglyConnectedCollectionJunctionsDfs( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctionsTriplet';
  var gr = context.cycledJunctionsTriplet();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'all nodes';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }

  var outNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'a2+b1+c+b2+a1+a0 : ' ];
  test.identical( outNodes, expected );

  var inNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.inNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'a2+b1+c+b2+a1+a0 : ' ];
  test.identical( inNodes, expected );

  var originalOutNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + group.nodesToNames( dnode.originalOutNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'a2+b1+c+b2+a1+a0 : b1.c.b2.a1.a0.a2' ];
  test.identical( originalOutNodes, expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycledJunctions3';
  var gr = context.cycledJunctions3();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'all nodes';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );

  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }

  var outNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : ', 'a+b+c1+g+c2 : d+e+f' ];
  test.identical( outNodes, expected );

  var inNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.inNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : a+b+c1+g+c2', 'a+b+c1+g+c2 : ' ];
  test.identical( inNodes, expected );

  var originalOutNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + group.nodesToNames( dnode.originalOutNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : e.f.d', 'a+b+c1+g+c2 : b.d.c1.c2.g.a' ];
  test.identical( originalOutNodes, expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycledJunctions4';
  var gr = context.cycledJunctions4();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'all nodes';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }

  var outNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : ', 'b2+c1+c2+b1 : ', 'g : b2+c1+c2+b1', 'a : d+e+f.g' ];
  test.identical( outNodes, expected );

  var inNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.inNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : a', 'b2+c1+c2+b1 : g', 'g : a', 'a : ' ];
  test.identical( inNodes, expected );

  var originalOutNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + group.nodesToNames( dnode.originalOutNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : e.f.d', 'b2+c1+c2+b1 : c1.c2.b1.b2', 'g : b1.c2.b2.c1', 'a : d.g' ];
  test.identical( originalOutNodes, expected );

  gr.sys.finit();

  /* - */

  test.case = 'cycledJunctions5';
  var gr = context.cycledJunctions5();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'all nodes';
  var group = gr.sys.nodesGroup();
  var collection2 = group.nodesStronglyConnectedCollectionDfs( gr.nodes );
  collection2.group.onNodeName = function onNodeName( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }

  var outNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.outNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : ', 'b2+c1+c2+b1 : ', 'g : b2+c1+c2+b1', 'a1+a0 : d+e+f.g' ];
  test.identical( outNodes, expected );

  var inNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + collection2.group.nodesToNames( dnode.inNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : a1+a0', 'b2+c1+c2+b1 : g', 'g : a1+a0', 'a1+a0 : ' ];
  test.identical( inNodes, expected );

  var originalOutNodes = collection2.nodes.map( ( dnode ) =>
  {
    return collection2.group.nodeToName( dnode ) + ' : ' + group.nodesToNames( dnode.originalOutNodes ).join( '.' );
  }).toArray().original;
  var expected = [ 'd+e+f : e.f.d', 'b2+c1+c2+b1 : c1.c2.b1.b2', 'g : b1.c2.g.b2.c1', 'a1+a0 : d.g' ];
  test.identical( originalOutNodes, expected );

  gr.sys.finit();

  /* - */

}

//

function rootsExportInfoTree( test )
{
  let context = this;

  /* - */

  test.case = 'cycled1Scc';
  var gr = context.cycled1Scc();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'a';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
   +-- b
   | +-- a
   +-- c
`;
  var treeInfo = group.rootsExportInfoTree( gr.a );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'array of a';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
   +-- b
   | +-- a
   +-- c
`
  var treeInfo = group.rootsExportInfoTree([ gr.a ]);
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'set of a';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
   +-- b
   | +-- a
   +-- c
`
  var treeInfo = group.rootsExportInfoTree( new Set([ gr.a ]) );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- b
   +-- a
     +-- b
     +-- c
`
  var treeInfo = group.rootsExportInfoTree( gr.b );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'array of b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- b
   +-- a
     +-- b
     +-- c
`
  var treeInfo = group.rootsExportInfoTree([ gr.b ]);
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'set of b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- b
   +-- a
     +-- b
     +-- c
`
  var treeInfo = group.rootsExportInfoTree( new Set([ gr.b ]) );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'array of a';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
   +-- b
   | +-- a
   +-- c
`
  var treeInfo = group.rootsExportInfoTree([ gr.a ]);
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'array of a, b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
 | +-- b
 | | +-- a
 | +-- c
 |
 +-- b
   +-- a
     +-- b
     +-- c
`
  var treeInfo = group.rootsExportInfoTree([ gr.a, gr.b ]);
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'set of a, b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
 | +-- b
 | | +-- a
 | +-- c
 |
 +-- b
   +-- a
     +-- b
     +-- c
`

  var treeInfo = group.rootsExportInfoTree( new Set([ gr.a, gr.b ]) );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycledOmicron';
  var gr = context.cycledOmicron();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'a';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
   +-- d
   | +-- b
   |   +-- d
   |   +-- f
   |     +-- e
   |       +-- c
   |         +-- d
   |         +-- f
   +-- f
     +-- e
       +-- c
         +-- d
         | +-- b
         |   +-- d
         |   +-- f
         +-- f
`
  var treeInfo = group.rootsExportInfoTree( gr.a );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- b
   +-- d
   | +-- b
   +-- f
     +-- e
       +-- c
         +-- d
         | +-- b
         +-- f
`
  var treeInfo = group.rootsExportInfoTree( gr.b );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'array of a, b';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
 | +-- d
 | | +-- b
 | |   +-- d
 | |   +-- f
 | |     +-- e
 | |       +-- c
 | |         +-- d
 | |         +-- f
 | +-- f
 |   +-- e
 |     +-- c
 |       +-- d
 |       | +-- b
 |       |   +-- d
 |       |   +-- f
 |       +-- f
 |
 +-- b
   +-- d
   | +-- b
   +-- f
     +-- e
       +-- c
         +-- d
         | +-- b
         +-- f
`
  var treeInfo = group.rootsExportInfoTree([ gr.a, gr.b ]);
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  gr.sys.finit();

  /* - */

  test.case = 'cycled4Scc';
  var gr = context.cycled4Scc();
  var group = gr.sys.nodesGroup();
  logger.log( 'DAG' )
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'single a';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a
   +-- b
     +-- e
     | +-- a
     | +-- c
     | | +-- b
     | +-- h
     |   +-- i
     |     +-- f
     |     +-- h
     +-- f
  `

  var treeInfo = group.rootsExportInfoTree([ gr.a ]);
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'single b';
  var group = gr.sys.nodesGroup();
  var expected =
  `
 +-- b
   +-- e
   | +-- a
   | | +-- b
   | +-- c
   | | +-- b
   | +-- h
   |   +-- i
   |     +-- f
   |     +-- h
   +-- f
  `
  var treeInfo = group.rootsExportInfoTree([ gr.b ]);
  var group = gr.sys.nodesGroup();
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'multiple: a, b, c';
  var expected =
  `
 +-- a
 | +-- b
 |   +-- e
 |   | +-- a
 |   | +-- c
 |   | | +-- b
 |   | +-- h
 |   |   +-- i
 |   |     +-- f
 |   |     +-- h
 |   +-- f
 |
 +-- b
 | +-- e
 | | +-- a
 | | | +-- b
 | | +-- c
 | | | +-- b
 | | +-- h
 | |   +-- i
 | |     +-- f
 | |     +-- h
 | +-- f
 |
 +-- c
   +-- b
     +-- e
     | +-- a
     | | +-- b
     | +-- c
     | +-- h
     |   +-- i
     |     +-- f
     |     +-- h
     +-- f
  `
  var treeInfo = group.rootsExportInfoTree([ gr.a, gr.b, gr.c ]);
  var group = gr.sys.nodesGroup();
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'multiple, rootsDelimiting : 0';
  var group = gr.sys.nodesGroup();
  var expected =
  `
 +-- a
 | +-- b
 |   +-- e
 |   | +-- a
 |   | +-- c
 |   | | +-- b
 |   | +-- h
 |   |   +-- i
 |   |     +-- f
 |   |     +-- h
 |   +-- f
 +-- b
 | +-- e
 | | +-- a
 | | | +-- b
 | | +-- c
 | | | +-- b
 | | +-- h
 | |   +-- i
 | |     +-- f
 | |     +-- h
 | +-- f
 +-- c
   +-- b
     +-- e
     | +-- a
     | | +-- b
     | +-- c
     | +-- h
     |   +-- i
     |     +-- f
     |     +-- h
     +-- f
  `
  var treeInfo = group.rootsExportInfoTree( [ gr.a, gr.b, gr.c ], { rootsDelimiting : 0 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
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
       +-- h
`
  var treeInfo = group.rootsExportInfoTree( sources );
  test.equivalent( treeInfo, exp );
  logger.log( 'Tree' );
  logger.log( treeInfo );

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
 |   | +-- a
 |   | +-- c
 |   | | +-- b
 |   | +-- h
 |   |   +-- i
 |   |     +-- f
 |   |     +-- h
 |   +-- f
 |
 +-- e
 | +-- a
 | | +-- b
 | |   +-- e
 | |   +-- f
 | +-- c
 | | +-- b
 | |   +-- e
 | |   +-- f
 | +-- h
 |   +-- i
 |     +-- f
 |     +-- h
 |
 +-- c
 | +-- b
 |   +-- e
 |   | +-- a
 |   | | +-- b
 |   | +-- c
 |   | +-- h
 |   |   +-- i
 |   |     +-- f
 |   |     +-- h
 |   +-- f
 |
 +-- i
   +-- f
   +-- h
     +-- i
`
  var treeInfo = group.rootsExportInfoTree( sources );
  test.equivalent( treeInfo, exp );
  logger.log( 'Tree' );
  logger.log( treeInfo );

  test.description = 'multiple + leastOutdegreeOnlyAmong a';
  var group = gr.sys.nodesGroup();
  var exp = [ 'f' ];
  var sources = group.leastOutdegreeOnlyAmong( group.rootsToAllReachable([ gr.a ]) );
  test.identical( group.nodesToNames( sources.original ), exp );
  var exp = `+-- f`;
  var treeInfo = group.rootsExportInfoTree( sources );
  test.equivalent( treeInfo, exp );
  logger.log( 'Tree' );
  logger.log( treeInfo );

  test.description = 'multiple + sourcesOnlyAmong a';
  var group = gr.sys.nodesGroup();
  var exp = [];
  var sources = group.sourcesOnlyAmong( group.rootsToAllReachable([ gr.a ]) );
  test.identical( group.nodesToNames( sources.original ), exp );
  var exp = '';
  var treeInfo = group.rootsExportInfoTree( sources );
  test.equivalent( treeInfo, exp );
  logger.log( 'Tree' );
  logger.log( treeInfo );

} /* end of function rootsExportInfoTree */

//

function rootsExportInfoTreeJunctionsTrivial( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctionsTriplet';
  var gr = context.cycledJunctionsTriplet();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

  test.description = 'a0';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
   +-- c
   | +-- b2
   | | +-- a2
   | | +-- a0
   | | +-- a1
   | +-- b1
   |   +-- a1
   |   +-- a0
   |   +-- a2
   +-- b1
   | +-- a1
   | +-- a0
   | +-- a2
   +-- b2
     +-- a2
     +-- a0
     +-- a1
`
  var treeInfo = group.rootsExportInfoTree( gr.a0 );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'empty array';
  var group = gr.sys.nodesGroup();
  var expected =
`
`
  var treeInfo = group.rootsExportInfoTree( [] );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  test.description = 'empty set';
  var group = gr.sys.nodesGroup();
  var expected =
`
`
  var treeInfo = group.rootsExportInfoTree( new Set );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  gr.sys.finit();

  /* - */

}

//

function rootsExportInfoTreeJunctions( test )
{
  let context = this;

  /* - */

  test.case = 'cycledJunctions5';
  var gr = context.cycledJunctions5();
  var group = gr.sys.nodesGroup();
  logger.log( group.nodesInfoExport( gr.nodes ) );
  group.finit();

//   test.description = 'default';
//   var group = gr.sys.nodesGroup();
//   var expected =
// `
//  +-- a0
//    +-- d
//    | +-- e
//    |   +-- f
//    +-- g
//      +-- b1
//      | +-- c1
//      | +-- c2
//      +-- c2
//      | +-- b2
//      | +-- b1
//      +-- b2
//      | +-- c1
//      | +-- c2
//      +-- c1
//        +-- b1
//        +-- b2
// `
//   var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ] );
//   test.equivalent( treeInfo, expected );
//   logger.log( 'Tree' );
//   logger.log( treeInfo );
//   group.finit();

  /* */

  test.description = 'allSiblings:0 allVariants:0';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
   +-- d
   | +-- e
   |   +-- f
   |     +-- d
   +-- g
     +-- b1
     | +-- c1
     |   +-- b1
     +-- c2
     | +-- b2
     |   +-- c1
     +-- g
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 0, allVariants : 0 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:0 allVariants:1 ';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   +-- g
 |   +-- b2
 |   +-- c1
 |
 +-- a1
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 0, allVariants : 1 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:0 allVariants:2 ';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   |   +-- c1
 |   |   +-- c2
 |   +-- g
 |   +-- b2
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c1
 |     +-- b1
 |     | +-- c1
 |     | +-- c2
 |     +-- b2
 |       +-- c1
 |       +-- c2
 |
 +-- a1
   +-- d
   | +-- e
   |   +-- f
   |     +-- d
   +-- g
     +-- b1
     | +-- c1
     | | +-- b1
     | | +-- b2
     | +-- c2
     |   +-- b2
     |   +-- b1
     +-- c2
     | +-- b2
     | | +-- c1
     | | +-- c2
     | +-- b1
     |   +-- c1
     |   +-- c2
     +-- g
     +-- b2
     | +-- c1
     | | +-- b1
     | | +-- b2
     | +-- c2
     |   +-- b2
     |   +-- b1
     +-- c1
       +-- b1
       | +-- c1
       | +-- c2
       +-- b2
         +-- c1
         +-- c2
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 0, allVariants : 2 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:1 allVariants:0';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   |   +-- b1
 |   +-- c2
 |   | +-- b2
 |   |   +-- c1
 |   +-- g
 |
 +-- a0
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 1, allVariants : 0 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:1 allVariants:1 ';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   +-- g
 |   +-- b2
 |   +-- c1
 |
 +-- a0
 |
 +-- a1
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 1, allVariants : 1 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:1 allVariants:2 ';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   |   +-- c1
 |   |   +-- c2
 |   +-- g
 |   +-- b2
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c1
 |     +-- b1
 |     | +-- c1
 |     | +-- c2
 |     +-- b2
 |       +-- c1
 |       +-- c2
 |
 +-- a0
 |
 +-- a1
   +-- d
   | +-- e
   |   +-- f
   |     +-- d
   +-- g
     +-- b1
     | +-- c1
     | | +-- b1
     | | +-- b2
     | +-- c2
     |   +-- b2
     |   +-- b1
     +-- c2
     | +-- b2
     | | +-- c1
     | | +-- c2
     | +-- b1
     |   +-- c1
     |   +-- c2
     +-- g
     +-- b2
     | +-- c1
     | | +-- b1
     | | +-- b2
     | +-- c2
     |   +-- b2
     |   +-- b1
     +-- c1
       +-- b1
       | +-- c1
       | +-- c2
       +-- b2
         +-- c1
         +-- c2
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 1, allVariants : 2 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:2 allVariants:0';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   |   +-- b1
 |   +-- c2
 |   | +-- b2
 |   |   +-- c1
 |   +-- g
 |
 +-- a0
   +-- d
   | +-- e
   |   +-- f
   |     +-- d
   +-- g
     +-- b1
     | +-- c1
     |   +-- b1
     +-- c2
     | +-- b2
     |   +-- c1
     +-- g
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 2, allVariants : 0 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:2 allVariants:1 ';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   +-- g
 |   +-- b2
 |   +-- c1
 |
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   +-- g
 |   +-- b2
 |   +-- c1
 |
 +-- a1
`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 2, allVariants : 1 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  test.description = 'allSiblings:2 allVariants:2 ';
  var group = gr.sys.nodesGroup();
  var expected =
`
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   |   +-- c1
 |   |   +-- c2
 |   +-- g
 |   +-- b2
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c1
 |     +-- b1
 |     | +-- c1
 |     | +-- c2
 |     +-- b2
 |       +-- c1
 |       +-- c2
 |
 +-- a0
 | +-- d
 | | +-- e
 | |   +-- f
 | |     +-- d
 | +-- g
 |   +-- b1
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c2
 |   | +-- b2
 |   | | +-- c1
 |   | | +-- c2
 |   | +-- b1
 |   |   +-- c1
 |   |   +-- c2
 |   +-- g
 |   +-- b2
 |   | +-- c1
 |   | | +-- b1
 |   | | +-- b2
 |   | +-- c2
 |   |   +-- b2
 |   |   +-- b1
 |   +-- c1
 |     +-- b1
 |     | +-- c1
 |     | +-- c2
 |     +-- b2
 |       +-- c1
 |       +-- c2
 |
 +-- a1
   +-- d
   | +-- e
   |   +-- f
   |     +-- d
   +-- g
     +-- b1
     | +-- c1
     | | +-- b1
     | | +-- b2
     | +-- c2
     |   +-- b2
     |   +-- b1
     +-- c2
     | +-- b2
     | | +-- c1
     | | +-- c2
     | +-- b1
     |   +-- c1
     |   +-- c2
     +-- g
     +-- b2
     | +-- c1
     | | +-- b1
     | | +-- b2
     | +-- c2
     |   +-- b2
     |   +-- b1
     +-- c1
       +-- b1
       | +-- c1
       | +-- c2
       +-- b2
         +-- c1
         +-- c2

`
  var treeInfo = group.rootsExportInfoTree( [ gr.a0, gr.a0, gr.a1 ], { allSiblings : 2, allVariants : 2 } );
  test.equivalent( treeInfo, expected );
  logger.log( 'Tree' );
  logger.log( treeInfo );
  group.finit();

  /* */

  gr.sys.finit();

  /* - */

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.AbstractGraph',
  silencing : 1,
  routineTimeOut : 10000,

  context :
  {

    dag6,
    cycled0Scc,
    cycled1Scc,
    cycled2Scc,
    cycled3Scc,
    cycled4Scc,
    _cycledJunctions,
    cycledJunctionsTriplet,
    cycledJunctions2,
    cycledJunctions3,
    cycledJunctions4,
    cycledJunctions5,
    cycledOmicron,
    cycledGamma,
    cycledAsymetricZeta,
    cycledAsymetricChi,

  },

  tests :
  {

    makeByNodes,
    makeByNodesWithInts,
    groupClone,
    collectionClone,
    cacheInNodesJunctions,
    reverse,

    asNodes,
    sourcesFromNodes,
    sourcesFromNodesJunctions,
    sourcesFromRoots,
    rootsToAllReachable,
    rootsToAllReachableJunctions,
    rootsToAll,
    rootsToAllJunctions,

    sinksOnlyAmong,
    sourcesOnlyAmong,
    leastMostDegreeAmong,

/*
qqq : add missing look*Junction* test routines
ask for more details
*/

    lookBfs,
    lookBfsVisitedContainter,
    lookBfsSuspending,
    lookBfsRevisiting,
    lookBfsExcluding,
    lookBfsRevisitingTrivial,
    lookBfsRepeatsRoots,
    lookBfsRepeatsRootsAllSiblings0,
    lookBfsRepeatsRootsAllSiblings1,
    lookBfsRepeatsRootsAllSiblings2,
    lookBfsJunctions,
    lookBfsJunctionsAllVariants0,
    lookBfsJunctionsAllVariants1,
    lookBfsJunctionsAllVariants2,

    lookDfs,
    lookDfsVisitedContainter,
    lookDfsSuspending,
    lookDfsRevisiting,
    lookDfsExcluding,
    lookDfsRevisitingTrivial,
    lookDfsRepeatsRoots,
    lookDfsRepeatsRootsAllSiblings0,
    lookDfsRepeatsRootsAllSiblings1,
    lookDfsRepeatsRootsAllSiblings2,
    lookDfsJunctions,
    lookDfsJunctionsAllVariants0,
    lookDfsJunctionsAllVariants0AllSiblings0,
    lookDfsJunctionsAllVariants0AllSiblings1,
    lookDfsJunctionsAllVariants0AllSiblings2,
    lookDfsJunctionsAllVariants1,
    lookDfsJunctionsAllVariants1AllSiblings0,
    lookDfsJunctionsAllVariants1AllSiblings1,
    lookDfsJunctionsAllVariants1AllSiblings2,
    lookDfsJunctionsAllVariants2,
    lookDfsJunctionsAllVariants2AllSiblings0,
    lookDfsJunctionsAllVariants2AllSiblings1,
    lookDfsJunctionsAllVariants2AllSiblings2,

    lookCfs,
    lookCfsVisitedContainter,
    lookCfsSuspending,
    lookCfsRevisiting,
    lookCfsExcluding,
    lookCfsRevisitingTrivial,
    lookCfsRepeatsRoots,
    lookCfsJunctions,

    eachBfs,
    eachDfs,
    eachCfs,

    dagTopSortDfs,
    topSortLeastDegreeBfs,
    topSortCycledSourceBasedFastBfs,
    topSortCycledSourceBasedPrecise,
    topSortCycledSourceBasedPreciseJunction,

    // connectivity

    pairDirectedPathGetDfs,
    pairDirectedPathExistsDfs,
    pairIsConnectedDfs,
    pairIsConnectedStronglyDfs,

    nodesConnectedLayersDfs,
    nodesStronglyConnectedLayersDfs,
    nodesStronglyConnectedCollectionDfs,
    nodesStronglyConnectedCollectionJunctionsDfs,

    rootsExportInfoTree,
    rootsExportInfoTreeJunctionsTrivial,
    rootsExportInfoTreeJunctions,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
