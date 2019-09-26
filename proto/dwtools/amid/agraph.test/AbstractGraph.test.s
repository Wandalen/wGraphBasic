( function _AbstractGraph_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../../Tools.s' );

  _.include( 'wTesting' );

  require( '../graphBasic/IncludeTop.s' );

}

var _ = wTools;

//

function makeByNodes( test )
{
  let context = this;

  test.case = 'init, add, delete, finit';

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.nodesGroup();
  test.identical( group.nodes.toArray().original, [] );

  test.is( sys === group.sys );
  test.identical( sys.groups.length, 1 );

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  d.nodes.push();
  e.nodes.push( c );

  test.identical( group.hasNode( a ), false );
  test.identical( sys.hasNode( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( group.hasNode( a ), true );
  test.identical( sys.hasNode( a ), true );

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodeDelete( d );
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 4 );
  test.identical( sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 1, 2, 3, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  sys.finit();

  /* */

  test.case = 'nodesDelete';

  var sys = new _.graph.AbstractGraphSystem
  ({
    onNodeNameGet : _.graph.AbstractNodesGroup.prototype.nodeNameFromFieldName
  });
  var group = sys.nodesGroup();

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  d.nodes.push();
  e.nodes.push( c );

  test.identical( group.hasNode( a ), false );
  test.identical( sys.hasNode( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodesDelete([ a, d, e ]);
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 2 );
  test.identical( sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [ 2, 3 ] );
  logger.log( group.infoExport() );

  group.nodesDelete();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes.toArray().original ), [] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  sys.finit();

}

//

function makeByNodesWithInts( test )
{
  let context = this;

  test.case = 'init, add, delete, finit';

  function onNodeNameGet( node ){ return node };
  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : onNodeNameGet });
  var group = sys.nodesGroup();

  group.onOutNodesGet = function onOutNodesGet( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+nodes.length );
    let result = nodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  test.is( sys === group.sys );
  test.identical( sys.groups.length, 1 );

  var a = 11;
  var b = 12;
  var c = 13;
  var d = 14;
  var e = 15;

  var nodes = [];
  nodes[ 0 ] = [ b, c ];
  nodes[ 1 ] = [ a ];
  nodes[ 2 ] = [ a, e ];
  nodes[ 3 ] = [];
  nodes[ 4 ] = [ c ];

  test.identical( group.hasNode( a ), false );
  test.identical( sys.hasNode( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( group.hasNode( a ), true );
  test.identical( sys.hasNode( a ), true );

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodeDelete( d );
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 4 );
  test.identical( sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  sys.finit();

  /* */

  test.case = 'nodesDelete';

  function onNodeNameGet( node ){ return node };
  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : onNodeNameGet });
  var group = sys.nodesGroup();

  test.is( sys.onNodeNameGet === onNodeNameGet );
  test.is( group.onNodeNameGet === onNodeNameGet );

  group.onOutNodesGet = function onOutNodesGet( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+nodes.length );
    let result = nodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  test.is( sys === group.sys );
  test.identical( sys.groups.length, 1 );

  var a = 11;
  var b = 12;
  var c = 13;
  var d = 14;
  var e = 15;

  var nodes = [];
  nodes[ 0 ] = [ b, c ];
  nodes[ 1 ] = [ a ];
  nodes[ 2 ] = [ a, e ];
  nodes[ 3 ] = [];
  nodes[ 4 ] = [ c ];

  test.identical( group.hasNode( a ), false );
  test.identical( sys.hasNode( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.nodesDelete([ a, d, e ]);
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 2 );
  test.identical( sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 2, 3 ] );
  logger.log( group.infoExport() );

  group.nodesDelete();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  sys.finit();

}

//

function clone( test )
{
  let context = this;

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  e.nodes.push( c );

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( sys.groups.length, 1 );

  group2.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( sys.groups.length, 0 );

  sys.finit();

  /* */

  test.case = 'node delete';

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  e.nodes.push( c );

  var sys = new _.graph.AbstractGraphSystem
  ({
    onNodeNameGet : _.graph.AbstractNodesGroup.prototype.nodeNameFromFieldName
  });

  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  group.nodeDelete( a );
  group2.nodeDelete( b );

  test.identical( group.hasNode( a ), false );
  test.identical( group.hasNode( b ), true );
  test.identical( group2.hasNode( a ), true );
  test.identical( group2.hasNode( b ), false );
  test.identical( sys.hasNode( a ), true );
  test.identical( sys.hasNode( b ), true );

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 4 );
  test.identical( group2.nodes.length, 4 );
  test.identical( sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group2.nodeDelete( a )
  group.nodeDelete( b );

  test.identical( group.hasNode( a ), false );
  test.identical( group.hasNode( b ), false );
  test.identical( group2.hasNode( a ), false );
  test.identical( group2.hasNode( b ), false );
  test.identical( sys.hasNode( a ), false );
  test.identical( sys.hasNode( b ), false );

  test.identical( sys.nodeDescriptorsHash.size, 3 );
  test.identical( sys.idToNodeHash.size, 3 );
  test.identical( sys.nodeToIdHash.size, 3 );
  test.identical( group.nodes.length, 3 );
  test.identical( group2.nodes.length, 3 );
  test.identical( sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 3, 4, 5 ] );
  logger.log( group.infoExport() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 3 );
  test.identical( sys.idToNodeHash.size, 3 );
  test.identical( sys.nodeToIdHash.size, 3 );
  test.identical( sys.groups.length, 1 );

  group2.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( sys.groups.length, 0 );

  sys.finit();

}

//

function reverse( test )
{
  let context = this;

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( e );
  e.nodes.push( b );

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  group2.cacheInNodesFromOutNodesOnce();
  group2.reverse();

  logger.log( 'direct' );
  logger.log( group.infoExport() );
  logger.log( 'reverse' );
  logger.log( group2.infoExport() );

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group.nodesOutNodesFor( group.nodes ).map( ( nodes ) => group.nodesToIds( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );
  var expected = [ [ 2 ], [ 1, 5 ], [ 1 ], [], [ 3 ] ];
  var outNodes = group2.nodesOutNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group2.nodesInNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );

  group2.reverse();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ).toArray().original, [ 1, 2, 3, 4, 5 ] );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group.nodesOutNodesFor( group.nodes ).map( ( nodes ) => group.nodesToIds( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group2.nodesOutNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );
  var expected = [ [ 2 ], [ 1, 5 ], [ 1 ], [], [ 3 ] ];
  var outNodes = group2.nodesInNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ).toArray().original ).toArray().original;
  test.identical( outNodes, expected );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( sys.groups.length, 1 );

  group2.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( sys.groups.length, 0 );

  sys.finit();

}

//

function nodesAs( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a' ];
  var dst = g.a;
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );

  test.case = '[ a ]';
  var exp = [ 'a' ];
  var dst = [ g.a ];
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b' ];
  var dst = [ g.a, g.b ];
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a' ];
  var dst = g.a;
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.arrayIs( got ) );

  test.case = '[ a ]';
  var exp = new Set([ 'a' ]);
  var dst = new Set([ g.a ]);
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.setIs( got ) );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b' ]);
  var dst = new Set([ g.a, g.b ]);
  var got = group.nodesAs( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( _.setIs( got ) );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function sourcesFromRoots( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'all';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var got = group.sourcesFromRoots( null, g.nodes );
  debugger;
  test.identical( group.nodesToNames( got ).original, exp );
  debugger;

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = g.a;
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.a ];
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ g.a, g.c ];
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.a, g.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.j, g.a, g.b ];
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = g.a;
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a, g.c ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a, g.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.j, g.a, g.b ]);
  var got = group.sourcesFromRoots( dst );
  test.identical( group.nodesToNames( got ).original, exp );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsAllReachable( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = g.a;
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.a ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ g.a, g.c ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.a, g.b ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.j, g.a, g.b ];
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = g.a;
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a, g.c ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a, g.b ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.j, g.a, g.b ]);
  var got = group.rootsAllReachable( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'set' );

  /* - */

}

//

function rootsAll( test )
{
  let context = this;

  /* - */

  test.open( 'array' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = g.a;
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.a ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = [ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ];
  var dst = [ g.a, g.c ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.a, g.b ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = [ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = [ g.j, g.a, g.b ];
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'array' );

  /* - */

  test.open( 'set' );

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'a';
  var exp = [ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ];
  var dst = g.a;
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );

  test.case = '[ a ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, c ]';
  var exp = new Set([ 'a', 'c', 'b', 'e', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a, g.c ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ a, b ]';
  var exp = new Set([ 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.a, g.b ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  test.case = '[ j, a, b ]';
  var exp = new Set([ 'j', 'a', 'b', 'e', 'c', 'h', 'i', 'f' ]);
  var dst = new Set([ g.j, g.a, g.b ]);
  var got = group.rootsAll( dst );
  test.identical( group.nodesToNames( got ), exp );
  test.is( got === dst )

  g.sys.finit();

  test.close( 'set' );

  /* - */

}


//

function sinksOnlyAmong( test )
{
  let context = this;

  test.case = 'cycled4';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.case = 'explicit';
  var got = group.sinksOnlyAmong( g.nodes );
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ).original, expected );

  test.case = 'implicit';
  group.nodesAdd( g.nodes );
  var got = group.sinksOnlyAmong();
  var expected = new Set([ 'f', 'j' ]);
  test.identical( group.nodesToNames( got ).original, expected );

  g.sys.finit();
}

//

function sourcesOnlyAmong( test )
{
  let context = this;

  test.case = 'setup';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  group.nodesAdd( g.nodes );
  var got = group.sourcesOnlyAmong();
  var expected = new Set([ 'd', 'j' ]);
  test.identical( group.nodesToNames( got ).original, expected );

  g.sys.finit();
}

//

function leastMostDegreeAmong( test )
{
  let context = this;

  test.case = 'cycled4';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();
  group.nodesAdd( g.nodes );

  var got = group.leastIndegreeAmong();
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong();
  var expected = new Set([ 'd', 'j' ]);
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostIndegreeAmong();
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong();
  var expected = new Set([ 'h' ]);
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.leastOutdegreeAmong();
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong();
  var expected = new Set([ 'f', 'j' ]);
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostOutdegreeAmong();
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong();
  var expected = new Set([ 'e' ]);
  test.identical( group.nodesToNames( got ).original, expected );

  test.case = 'no least indegree';

  var got = group.leastIndegreeAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = 1;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = [ 'c', 'e', 'g', 'i' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostIndegreeAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.leastOutdegreeAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = [ 'f' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostOutdegreeAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ).original, expected );

  test.case = 'no most indegree';

  var got = group.leastIndegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostIndegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = 2;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = [ 'a', 'b', 'f' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.leastOutdegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostOutdegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.i, g.j ]);
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ).original, expected );

  test.case = 'no leasr outdegree';

  var got = group.leastIndegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = [ 'd' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostIndegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.leastOutdegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = 1;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = [ 'a', 'c', 'g', 'h' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostOutdegreeAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ).original, expected );

  test.case = 'no most outdegree';

  var got = group.leastIndegreeAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostIndegreeAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.leastOutdegreeAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ).original, expected );

  var got = group.mostOutdegreeAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = 2;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ g.a, g.b, g.c, g.d, g.f, g.g, g.h, g.i, g.j ]);
  var expected = [ 'b', 'd', 'i' ];
  test.identical( group.nodesToNames( got ).original, expected );

  g.sys.finit();
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
    debugger;
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

  test.case = 'setup';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  group.nodesAdd( g.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  /* */

  test.case = 'all';

  clean();
  var layers = group.lookBfs({ roots : group.nodes, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = [ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ] ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ).original ), expected );

  var expectedNds = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedUps = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedDws = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedLups =
  [
    new Set([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ]),
    [ 'b', 'e', 'f', 'b', 'a', 'g', 'a', 'c', 'h', 'h', 'i', 'f', 'h' ],
  ];
  var expectedLdws =
  [
    [],
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
  ];

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );
  debugger;

  /* */

  test.case = 'only a';

  clean();
  var layers = group.lookBfs({ roots : g.a, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = [ [ 'a' ], [ 'b' ], [ 'e', 'f' ], [ 'c', 'h' ], [ 'i' ] ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ).original ), expected );

  var expectedNds = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedUps = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedDws = [ 'i', 'c', 'h', 'e', 'f', 'b', 'a' ];
  var expectedLups =
  [
    [ 'a' ],
    [ 'b' ],
    [ 'e', 'f' ],
    [ 'a', 'c', 'h' ],
    [ 'b', 'i' ],
    [ 'f', 'h' ]
  ];
  var expectedLdws =
  [
    [],
    [ 'i' ],
    [ 'c', 'h' ],
    [ 'e', 'f' ],
    [ 'b' ],
    [ 'a' ]
  ];

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only d';

  clean();
  var layers = group.lookBfs({ roots : g.d, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ).original ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'c', 'e', 'f', 'i', 'b', 'h', 'a', 'g', 'd' ];
  var expectedLups =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'a', 'c', 'h', 'f', 'h' ],
    [ 'b' ]
  ]
  var expectedLdws =
  [
    [],
    [ 'c' ],
    [ 'e', 'f', 'i' ],
    [ 'b', 'h' ],
    [ 'a', 'g' ],
    [ 'd' ]
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'd and a';

  clean();
  var layers = group.lookBfs({ roots : [ g.d, g.a ], onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    [ 'd', 'a' ],
    [ 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'c' ]
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ).original ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'i', 'c', 'h', 'e', 'f', 'g', 'b', 'd', 'a' ];
  var expectedLups =
  [
    [ 'd', 'a' ],
    [ 'a', 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'a', 'c', 'h' ],
    [ 'f', 'h', 'b' ]
  ]
  var expectedLdws =
  [
    [],
    [ 'i', 'c' ],
    [ 'h', 'e', 'f' ],
    [ 'g', 'b' ],
    [ 'd', 'a' ]
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  g.sys.finit();

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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f' ];
    var expectedDws = [ 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];

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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedDws = [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];

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
      roots : b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'b' ];

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
      roots : e,
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
      roots : f,
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
      roots : a,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedDws = [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];

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
      roots : b,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'b' ];

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
      roots : e,
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
      roots : f,
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
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp3( nodes, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    lups.push( _.containerAdapter.toOriginal( group.nodesToNames( nodes ) ) );
  }

  function onLayerUp4( nodes, it )
  {
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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding elements';

    clean();
    group.lookBfs
    ({
      roots : a,
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
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
    ]
    var expectedLdws =
    [
      [],
      [ 'b', 'd' ],
      [ 'a' ]
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
      roots : b,
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
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'd' ],
      [ 'b' ]
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
      roots : a,
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
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
    ]
    var expectedLdws =
    [
      [],
      [ 'a' ]
    ]

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
      roots : b,
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
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'b' ]
    ]

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
      roots : a,
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
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
    ]
    var expectedLdws =
    [
      [ 'b', 'd' ],
      [ 'a' ]
    ]

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
      roots : b,
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
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
    ]
    var expectedLdws =
    [
      [ 'c', 'd' ],
      [ 'b' ]
    ]

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
      roots : a,
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
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
    ]
    var expectedLdws =
    [
      [],
      [ 'a' ]
    ]

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
      roots : b,
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
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'b' ]
    ]

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

  test.case = 'setup';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  group.nodesAdd( g.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  test.case = 'all'; /* */

  clean();
  group.lookDfs({ roots : group.nodes, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  a  b  e  c  h  i  f  d  g  j
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6, 4, 7, 10 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4, 10 ];
  //                  c  f  i  h  e  b  a  g  d  j

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  test.case = 'only a'; /* */

  clean();
  group.lookDfs({ roots : a, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  a  b  e  c  h  i  f
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1 ];
  //                  c  f  i  h  e  b  a

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  test.case = 'only d'; /* */

  clean();
  group.lookDfs({ roots : d, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  d  a  b  e  c  h  i  f  g
  var expectedUps = [ 4, 1, 2, 5, 3, 8, 9, 6, 7 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4 ];
  //                  c  f  i  h  e  b  a  g  d

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  /* */

  g.sys.finit();

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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  // group.nodesAdd([ a, b, c, d, e ]);
  // test.identical( group.nodes.length, 10 );
  // logger.log( group.infoExport() );

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding';

    clean();
    group.lookDfs
    ({
      roots : a,
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
      roots : b,
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
      roots : a,
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
      roots : b,
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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  // group.nodesAdd([ a, b, c, d, e ]);
  // test.identical( group.nodes.length, 10 );
  // logger.log( group.infoExport() );

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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
      roots : a,
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
      roots : b,
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
      roots : e,
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
      roots : f,
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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding';

    clean();
    group.lookDbfs
    ({
      roots : a,
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
      roots : b,
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
      roots : a,
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
      roots : b,
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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ).original, exp );
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : a, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : b, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : e, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', roots : f, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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

  test.case = 'setup'; // xxx : move to the context

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  debugger;
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a });
  debugger;
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  debugger; return; xxx

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ).original, exp );
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : a, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : b, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : e, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', roots : f, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, includingBranches : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, withTerminals : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ).original, exp );
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
    var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, recursive : 1 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : a, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : b, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : e, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', roots : f, recursive : 0 });
  test.identical( group.nodesToNames( got ).original, exp );
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

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, c );
  b.nodes.push( d, e );
  c.nodes.push();
  d.nodes.push( c );
  e.nodes.push( f );
  f.nodes.push();

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e, f ]);
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

  test.description = 'with help of all([ d ])'
  var ordering = group.dagTopSortDfs( group.rootsAllReachable([ d ]) );
  var expected = [ 'c', 'd' ];
  test.identical( group.nodesToNames( ordering ), expected );

  test.shouldThrowErrorSync( () =>
  {
    test.description = 'b';
    var ordering = group.dagTopSortDfs([ b ]);
    var expected = [ 'c', 'd', 'f', 'e', 'b' ];
    test.identical( group.nodesToNames( ordering ), expected );
  });

  /* */

  test.case = 'cycled';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  test.shouldThrowErrorSync( () =>
  {
    test.description = 'with help of all([ d ])'
    var ordering = group.dagTopSortDfs( [ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.h, g.i, g.j ] );
  });

  g.sys.finit();
}

//

function topSortSourceBasedBfs( test )
{
  let context = this;

  test.case = 'setup';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();

  // group.nodesAdd( g.nodes );
  logger.log( group.infoExport() );

  /* */

  test.case = 'all';

  var layers = group.topSortSourceBasedBfs();

  var expected =
  [
    [ 'd', 'j' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'not j';

  var layers = group.topSortSourceBasedBfs([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.h, g.i ]);

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

  test.case = 'not j, not d';

  var layers = group.topSortSourceBasedBfs([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);

  var expected =
  [
    [ 'c', 'e', 'g', 'i' ],
    [ 'b', 'a', 'h', 'f' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'c, e';

  var layers = group.topSortSourceBasedBfs([ c, e ]);

  var expected =
  [
    [ 'c', 'e' ],
    [ 'b', 'a', 'h' ],
    [ 'f', 'i' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  g.sys.finit();
  test.case = 'setup';

  // var a = { name : 'a', nodes : [] } // 1
  // var b = { name : 'b', nodes : [] } // 2
  // var c = { name : 'c', nodes : [] } // 3
  //
  // a.nodes.push( b, c ); // 1
  // b.nodes.push( a ); // 2
  // c.nodes.push(); // 3
  //
  // var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  var g = context.trivialCycledSigmaTriplet();
  var group = g.sys.nodesGroup();

  group.nodesAdd( g.nodes );
  logger.log( group.infoExport() );

  /* */

  var layers = group.topSortSourceBasedBfs();

  var expected =
  [
    [ 'a', 'b', 'c' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  g.sys.finit();

}

//

function topSortCycledSourceBasedBfs( test )
{
  let context = this;

  test.case = 'complex';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();
  group.nodesAdd( g.nodes ); // xxx
  logger.log( group.infoExport() );

  /* */

  test.description = 'all';

  var layers = group.topSortCycledSourceBasedBfs();

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

  var layers = group.topSortCycledSourceBasedBfs([ g.a, g.b, g.c, g.d, g.e, g.f, g.g, g.h, g.i ]);

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

  var layers = group.topSortCycledSourceBasedBfs([ g.a, g.b, g.c, g.e, g.f, g.g, g.h, g.i ]);

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

  test.shouldThrowErrorSync( () => group.topSortCycledSourceBasedBfs([ g.c, g.e ]) );

  var expected = [];

  g.sys.finit();

  /* - */

  test.case = 'trivial';

  // var a = { name : 'a', nodes : [] }
  // var b = { name : 'b', nodes : [] }
  // var c = { name : 'c', nodes : [] }
  //
  // a.nodes.push( b, c );
  // b.nodes.push( a );
  // c.nodes.push();
  //
  // var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });

  var g = context.trivialCycledSigmaTriplet();
  var group = g.sys.nodesGroup();
  group.nodesAdd( g.nodes ); // xxx
  logger.log( group.infoExport() );

  /* */

  var layers = group.topSortCycledSourceBasedBfs();

  var expected =
  [
    [ 'a', 'b' ],
    [ 'c' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  g.sys.finit();

  /* */

  test.case = 'cycled asymetric zeta';
  var g = context.cycledAsymetricZeta();
  var group = g.sys.nodesGroup();

  test.description = 'all';
  var layers = group.topSortCycledSourceBasedBfs( g.nodes );
  var expected = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  g.sys.finit();

  /* */

  test.case = 'cycled asymetric ex';

  var g = context.cycledAsymetricChi();
  var group = g.sys.nodesGroup();

  test.description = 'all';
  var layers = group.topSortCycledSourceBasedBfs( g.nodes );
  var expected = [ 'd', 'e', 'a', 'b', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  test.description = 'all a';
  debugger;
  var layers = group.topSortCycledSourceBasedBfs( group.rootsAllReachable( g.a ) );
  debugger;
  var expected = [ 'e', 'd', 'a', 'b', 'f', 'c', 'g', 'h', 'k', 'i', 'l', 'j', 'm' ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  g.sys.finit();

}

// --
// connectivity
// --

function pairDirectedPathGetDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var exp = [ 'a' ];
  var connected = group.pairDirectedPathGetDfs([ a, a ]);
  test.identical( group.nodesToNames( connected ), exp );

  var exp = [ 'b', 'a' ];
  var connected = group.pairDirectedPathGetDfs([ a, b ]);
  test.identical( group.nodesToNames( connected ), exp );

  var connected = group.pairDirectedPathGetDfs([ a, e ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathGetDfs([ a, g ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathGetDfs([ a, f ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathGetDfs([ a, g ]);
  test.identical( connected, false );

  test.description = 'g';

  var exp = [ 'g' ];
  var connected = group.pairDirectedPathGetDfs([ g, g ]);
  test.identical( group.nodesToNames( connected ), exp );

  var exp = [ 'f', 'g' ];
  var connected = group.pairDirectedPathGetDfs([ g, f ]);
  test.identical( group.nodesToNames( connected ), exp );

  var connected = group.pairDirectedPathGetDfs([ g, b ]);
  test.identical( connected, false );

  var exp = [ 'g', 'f' ];
  var connected = group.pairDirectedPathGetDfs([ f, g ]);
  test.identical( group.nodesToNames( connected ), exp );

  var exp = [ 'f' ];
  var connected = group.pairDirectedPathGetDfs([ f, f ]);
  test.identical( group.nodesToNames( connected ), exp );

  var connected = group.pairDirectedPathGetDfs([ f, b ]);
  test.identical( connected, false );

  /* - */

  test.case = 'cycled asymetric zeta';
  var g = context.cycledAsymetricZeta();
  var group = g.sys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairDirectedPathGetDfs([ a, h ]);
  test.identical( connected, false );

  test.description = 'h a';
  var exp = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ];
  var connected = group.pairDirectedPathGetDfs([ h, a ]);
  test.identical( group.nodesToNames( connected ), exp );

  /* */

  g.sys.finit();

}

//

function pairDirectedPathExistsDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var connected = group.pairDirectedPathExistsDfs([ a, a ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ a, b ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ a, e ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ a, g ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ a, f ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ a, g ]);
  test.identical( connected, false );

  test.description = 'g';

  var connected = group.pairDirectedPathExistsDfs([ g, g ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ g, f ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ g, b ]);
  test.identical( connected, false );

  var connected = group.pairDirectedPathExistsDfs([ f, g ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ f, f ]);
  test.identical( connected, true );

  var connected = group.pairDirectedPathExistsDfs([ f, b ]);
  test.identical( connected, false );

  /* - */

  test.case = 'cycled asymetric zeta';

  var g = context.cycledAsymetricZeta();
  var group = g.sys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairDirectedPathExistsDfs([ a, h ]);
  test.identical( connected, false );

  test.description = 'h a';
  var connected = group.pairDirectedPathExistsDfs([ h, a ]);
  test.identical( connected, true );

  /* */

  g.sys.finit();
}

//

function pairIsConnectedDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var connected = group.pairIsConnectedDfs([ a, a ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ a, b ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ a, e ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ a, g ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ a, f ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ a, g ]);
  test.identical( connected, false );

  test.description = 'g';

  var connected = group.pairIsConnectedDfs([ g, g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ g, f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ g, b ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedDfs([ f, g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ f, f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedDfs([ f, b ]);
  test.identical( connected, false );

  /* - */

  test.case = 'cycled asymetric zeta';

  var g = context.cycledAsymetricZeta();
  var group = gsys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairIsConnectedDfs([ a, h ]);
  test.identical( connected, true );

  test.description = 'h a';
  var connected = group.pairIsConnectedDfs([ h, a ]);
  test.identical( connected, true );

  /* */

  g.sys.finit();
}

//

function pairIsConnectedStronglyDfs( test )
{
  let context = this;

  /* - */

  test.case = 'simple';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.infoExport() );

  test.description = 'a';

  var connected = group.pairIsConnectedStronglyDfs([ a, a ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ a, b ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ a, e ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ a, g ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ a, f ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ a, g ]);
  test.identical( connected, false );

  test.description = 'g';

  var connected = group.pairIsConnectedStronglyDfs([ g, g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ g, f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ g, b ]);
  test.identical( connected, false );

  var connected = group.pairIsConnectedStronglyDfs([ f, g ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ f, f ]);
  test.identical( connected, true );

  var connected = group.pairIsConnectedStronglyDfs([ f, b ]);
  test.identical( connected, false );

  /* - */

  test.case = 'cycled asymetric zeta';
  var g = context.cycledAsymetricZeta();
  var group = sys.nodesGroup();

  /* */

  test.description = 'a h';
  var connected = group.pairIsConnectedStronglyDfs([ a, h ]);
  test.identical( connected, true );

  test.description = 'h a';
  var connected = group.pairIsConnectedStronglyDfs([ h, a ]);
  test.identical( connected, false );

  /* */

  g.sys.finit();
}

//

function nodesConnectedLayersDfs( test )
{
  let context = this;

  test.case = 'setup';

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.nodesGroup();

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
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

  /* - */

  test.case = 'cycled asymetric zeta';
  var g = context.cycledAsymetricZeta();

  /* */

  test.description = 'all';
  var group = g.sys.nodesGroup();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  var layers = group.nodesConnectedLayersDfs([ a, b, c, d, e, f, g, h ]);
  var names = layers.map( ( ids ) => group.idsToNames( ids ) );;
  var expected = [ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ] ]
  test.identical( names, expected );
  group.finit();

  /* */

  g.sys.finit();

}

//

function nodesStronglyConnectedLayersDfs( test )
{
  let context = this;

  test.case = 'setup';

  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();
  group.nodesAdd( g.nodes );
  test.identical( group.nodes.length, 10 );
  logger.log( group.infoExport() );

  var expected = [ [ j ], [ f ], [ i, h ], [ g ], [ a, b, e, c ], [ d ] ];
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

  g.finit();
}

//

function nodesStronglyConnectedTreeDfs( test )
{
  let context = this;

  /* - */

  // test.case = 'trivial';
  // var g = context.trivialCycledSigmaTriplet();
  //
  // /* */
  //
  // var group = g.sys.nodesGroup({});
  //
  // group.nodesAdd( g.nodes );
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
  // g.sys.finit();

  /* - */

  test.case = 'cycled asymetric zeta';
  var g = context.cycledAsymetricZeta();

  /* */

  // test.description = 'all';
  // var group = g.sys.nodesGroup();
  // var group2 = group.nodesStronglyConnectedTreeDfs( g.nodes );
  // group2.onNodeNameGet = function onNodeNameGet( dnode )
  // {
  //   return group.nodesToNames( dnode.originalNodes ).join( '+' );
  // }
  // var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  // var expected = [ 'h+f+g : ', 'e : h+f+g', 'd : e', 'a+b+c : d' ];
  // test.identical( outNodes, expected );
  // group.finit();

  /* */

  test.description = '[ a, h, g, f, e, d, c, b ]';
  var group = g.sys.nodesGroup();
  debugger;
  var group2 = group.nodesStronglyConnectedTreeDfs([ g.a, g.h, g.g, g.f, g.e, g.d, g.c, g.b ]);
  debugger;
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'h+f+g : ', 'e : h+f+g', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  debugger; return; xxx

  /* */

  test.description = 'all a';
  var group = g.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsAllReachable( a ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'a+b+c : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all c';
  var group = g.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsAllReachable( c ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e', 'c+a+b : d' ];
  test.identical( outNodes, expected );

  /* */

  test.description = 'all d';
  var group = g.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( group.rootsAllReachable( d ) );
  group2.onNodeNameGet = function onNodeNameGet( dnode )
  {
    return group.nodesToNames( dnode.originalNodes ).join( '+' );
  }
  var outNodes = group2.nodes.map( ( dnode ) => group2.nodeToName( dnode ) + ' : ' + group2.nodesToNames( dnode.outNodes ).join( '.' ) ).toArray().original;
  var expected = [ 'f+g+h : ', 'e : f+g+h', 'd : e' ];
  test.identical( outNodes, expected );

  sys.finit();

  /* - */

  test.case = 'complex'
  var g = context.cycled4StronglyConnectedLayers();

  /* */

  test.description = 'all';
  var group = g.sys.nodesGroup();
  group.nodesAdd( g.nodes );
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
  var group = g.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( g.nodes );
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
  var group = g.sys.nodesGroup();
  var group2 = group.nodesStronglyConnectedTreeDfs( g.connectedNodes );
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
  var group = g.sys.nodesGroup();
  test.shouldThrowErrorSync( () =>
  {
    var group2 = group.nodesStronglyConnectedTreeDfs([ g.a, g.b, g.c, g.d, g.e, g.g, g.h, g.i ]);
  });

  /* */

  g.sys.finit();

  /* - */

}

//

function nodesExportInfoTree( test )
{
  let context = this;

  test.case = '4 scl';
  var g = context.cycled4StronglyConnectedLayers();
  var group = g.sys.nodesGroup();
  group.nodesAdd( g.nodes );

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
  var infoAsTree = group.nodesExportInfoTree([ a ]);
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
  var infoAsTree = group.nodesExportInfoTree([ b ]);
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
  var infoAsTree = group.nodesExportInfoTree([ a, b, c ]);
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
  // var nodes0 = group.rootsAllReachable([ a, b, c ]);
  // debugger;
  // var nodes1 = group.dagTopSort( group.rootsAllReachable([ a, b, c ]) );
  // debugger;
  // var nodes2 = group.topSortCycledSourceBased( group.rootsAllReachable([ a, b, c ]) );
  // debugger;
  // var nodes3 = group.sourcesOnlyAmong( group.rootsAllReachable([ a, b, c ]) );
  // debugger;
  // var infoAsTree = group.nodesExportInfoTree( group.sourcesOnlyAmong( group.rootsAllReachable([ a, b, c ]) ) );
  // debugger;
  // test.equivalent( infoAsTree, expected );
  // logger.log( 'Tree' );
  // logger.log( infoAsTree );

} /* end of function nodesExportInfoTree */

// --
// context
// --

function trivialCycledSigmaTriplet()
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

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  let r = { sys, length }
  r.nodes = [ a, b, c ];
  r.nodes.forEach( ( e ) => r[ e.name ] = e );

  return r;
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

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  let r = { sys, length }
  r.nodes = [ a, b, c, d, e, f, g, h ];
  r.nodes.forEach( ( e ) => r[ e.name ] = e );

  return r;
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
        ↓        ↓
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

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  let r = { sys, length }
  r.nodes = [ a, b, c, d, e, f, g, h, i, j, k, l, m ];
  r.nodes.forEach( ( e ) => r[ e.name ] = e );

  return r;
}

//

function cycled4StronglyConnectedLayers()
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

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  let r = { sys, length }
  r.nodes = [ a, b, c, d, e, f, g, h, i, j ];
  r.connectedNodes = [ a, b, c, d, e, f, g, h, i ];
  r.nodes.forEach( ( e ) => r[ e.name ] = e );

  return r;
}

//

var Self =
{

  name : 'Tools.mid.AbstractGraph',
  silencing : 1,

  context :
  {
    trivialCycledSigmaTriplet,
    cycledAsymetricZeta,
    cycledAsymetricChi,
    cycled4StronglyConnectedLayers,
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
