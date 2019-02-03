( function _AbstractGraph_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../agraph/UseAbstractMid.s' );

}

var _ = wTools;

//

function makeByNodes( test )
{

  test.case = 'init, add, delete, finit';

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

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
  e.nodes.push( c );

  test.identical( group.nodeHas( a ), false );
  test.identical( sys.nodeHas( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( group.nodeHas( a ), true );
  test.identical( sys.nodeHas( a ), true );

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.nodeDelete( d );
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 4 );
  test.identical( sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 5 ] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  sys.finit();

  /* */

  test.case = 'nodesDelete';

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  e.nodes.push( c );

  group.nodesAdd([ a, b, c, d, e ]);
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.nodesDelete([ a, d, e ]);
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 2 );
  test.identical( sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 2, 3 ] );
  logger.log( group.exportInfo() );

  group.nodesDelete();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes ), [] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  sys.finit();

}

//

function clone( test )
{

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

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

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

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  group.nodeDelete( a );
  group2.nodeDelete( b );

  test.identical( group.nodeHas( a ), false );
  test.identical( group.nodeHas( b ), true );
  test.identical( group2.nodeHas( a ), true );
  test.identical( group2.nodeHas( b ), false );
  test.identical( sys.nodeHas( a ), true );
  test.identical( sys.nodeHas( b ), true );

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 4 );
  test.identical( group2.nodes.length, 4 );
  test.identical( sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group2.nodeDelete( a )
  group.nodeDelete( b );

  test.identical( group.nodeHas( a ), false );
  test.identical( group.nodeHas( b ), false );
  test.identical( group2.nodeHas( a ), false );
  test.identical( group2.nodeHas( b ), false );
  test.identical( sys.nodeHas( a ), false );
  test.identical( sys.nodeHas( b ), false );

  test.identical( sys.nodeDescriptorsHash.size, 3 );
  test.identical( sys.idToNodeHash.size, 3 );
  test.identical( sys.nodeToIdHash.size, 3 );
  test.identical( group.nodes.length, 3 );
  test.identical( group2.nodes.length, 3 );
  test.identical( sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 3, 4, 5 ] );
  logger.log( group.exportInfo() );

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

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  group2.onReverseNeighbourNodesGet = group2.cahcedOnReverseNeighbourNodesGet;
  group2.cacheReverseFromDirectNeigbourNodes();
  group2.reverse();

  logger.log( 'direct' );
  logger.log( group.exportInfo() );
  logger.log( 'reverse' );
  logger.log( group2.exportInfo() );

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 2, 3, 4, 5 ] );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var neighbours = group.nodesDirectNeigbourNodesGet( group.nodes ).map( ( nodes ) => group.nodesToIds( nodes ) );
  test.identical( neighbours, expected );
  var expected = [ [ 2 ], [ 1, 5 ], [ 1 ], [], [ 3 ] ];
  var neighbours = group2.nodesDirectNeigbourNodesGet( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( neighbours, expected );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var neighbours = group2.nodesReverseNeigbourNodesGet( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( neighbours, expected );

  group2.reverse();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 2, 3, 4, 5 ] );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var neighbours = group.nodesDirectNeigbourNodesGet( group.nodes ).map( ( nodes ) => group.nodesToIds( nodes ) );
  test.identical( neighbours, expected );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var neighbours = group2.nodesDirectNeigbourNodesGet( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( neighbours, expected );
  var expected = [ [ 2 ], [ 1, 5 ], [ 1 ], [], [ 3 ] ];
  var neighbours = group2.nodesReverseNeigbourNodesGet( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( neighbours, expected );

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

function sinksAmong( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  var got = group.sinksAmong();
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

}

//

function sourcesAmong( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  var got = group.sourcesAmong();
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

}

//

function lookDfs( test )
{

  var ups = [];
  var downs = [];

  function handleUp( nodeHandle, it )
  {
    ups.push( nodeHandle );
  }

  function handleDown( nodeHandle, it )
  {
    downs.push( nodeHandle );
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

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  test.case = 'all'; /* */

  var ups = [];
  var downs = [];
  group.lookDfs({ nodes : group.nodes, onUp : handleUp, onDown : handleDown });

  //                  a  b  e  c  h  i  f  d  g  j
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6, 4, 7, 10 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4, 10 ];
  //                  c  f  i  h  e  b  a  g  d  j

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( downs ), expectedDws );

  test.case = 'only a'; /* */

  var ups = [];
  var downs = [];
  group.lookDfs({ nodes : a, onUp : handleUp, onDown : handleDown });

  //                  a  b  e  c  h  i  f
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1 ];
  //                  c  f  i  h  e  b  a

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( downs ), expectedDws );

  test.case = 'only d'; /* */

  var ups = [];
  var downs = [];
  group.lookDfs({ nodes : d, onUp : handleUp, onDown : handleDown });

  //                  d  a  b  e  c  h  i  f  g
  var expectedUps = [ 4, 1, 2, 5, 3, 8, 9, 6, 7 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4 ];
  //                  c  f  i  h  e  b  a  g  d

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( downs ), expectedDws );

  /* */

  sys.finit();

}

//

function lookBfs( test )
{

  var ups = [];
  var downs = [];
  var nodes = [];

  function handleUp( nodes, it )
  {
    ups.push( group.nodesToNames( nodes ) );
  }

  function handleDown( nodes, it )
  {
    downs.push( group.nodesToNames( nodes ) );
  }

  function handleNode( node, it )
  {
    nodes.push( group.nodesToNames( node ) );
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

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  /* */

  test.case = 'all';

  var ups = [];
  var downs = [];
  var nodes = [];
  var layers = group.lookBfs({ nodes : group.nodes, onUp : handleUp, onDown : handleDown, onNode : handleNode });

  var expected = [ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ] ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedUps =
  [
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
    [ 'b', 'e', 'f', 'b', 'a', 'g', 'a', 'c', 'h', 'h', 'i', 'f', 'h' ],
  ];
  var expectedDws =
  [
    [],
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
  ];
  var expectedNodes = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];

  test.identical( ups, expectedUps );
  test.identical( downs, expectedDws );
  test.identical( nodes, expectedNodes );

  /* */

  test.case = 'only a';

  var ups = [];
  var downs = [];
  var nodes = [];
  var layers = group.lookBfs({ nodes : a, onUp : handleUp, onDown : handleDown, onNode : handleNode });

  var expected = [ [ 'a' ], [ 'b' ], [ 'e', 'f' ], [ 'c', 'h' ], [ 'i' ] ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedUps =
  [
    [ 'a' ],
    [ 'b' ],
    [ 'e', 'f' ],
    [ 'a', 'c', 'h' ],
    [ 'b', 'i' ],
    [ 'f', 'h' ]
  ];
  var expectedDws =
  [
    [],
    [ 'i' ],
    [ 'c', 'h' ],
    [ 'e', 'f' ],
    [ 'b' ],
    [ 'a' ]
  ];
  var expectedNodes = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];

  test.identical( ups, expectedUps );
  test.identical( downs, expectedDws );
  test.identical( nodes, expectedNodes );

  /* */

  test.case = 'only d';

  var ups = [];
  var downs = [];
  var nodes = [];
  var layers = group.lookBfs({ nodes : d, onUp : handleUp, onDown : handleDown, onNode : handleNode });

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedUps =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'a', 'c', 'h', 'f', 'h' ],
    [ 'b' ]
  ]
  var expectedDws =
  [
    [],
    [ 'c' ],
    [ 'e', 'f', 'i' ],
    [ 'b', 'h' ],
    [ 'a', 'g' ],
    [ 'd' ]
  ]
  var expectedNodes = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];

  test.identical( ups, expectedUps );
  test.identical( downs, expectedDws );
  test.identical( nodes, expectedNodes );

  /* */

  test.case = 'd and a';

  var ups = [];
  var downs = [];
  var nodes = [];
  var layers = group.lookBfs({ nodes : [ d, a ], onUp : handleUp, onDown : handleDown, onNode : handleNode });

  var expected =
  [
    [ 'd', 'a' ],
    [ 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'c' ]
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedUps =
  [
    [ 'd', 'a' ],
    [ 'a', 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'a', 'c', 'h' ],
    [ 'f', 'h', 'b' ]
  ]
  var expectedDws =
  [
    [],
    [ 'i', 'c' ],
    [ 'h', 'e', 'f' ],
    [ 'g', 'b' ],
    [ 'd', 'a' ]
  ]
  var expectedNodes = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];

  test.identical( ups, expectedUps );
  test.identical( downs, expectedDws );
  test.identical( nodes, expectedNodes );

  /* */

  sys.finit();

}

//

function topologicalSortDfs( test )
{

  test.case = 'trivial';

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

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f ]);
  logger.log( 'DAG' )
  logger.log( group.nodesExportInfo() );

  var ordering = group.topologicalSortDfs();
  logger.log( 'Ordering' )
  logger.log( group.nodesExportInfo( ordering ) );

  var expected = [ 3, 4, 6, 5, 2, 1 ];
  test.identical( group.nodesToIds( ordering ), expected );

}

//

function topologicalSortSourceBasedBfs( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  /* */

  test.case = 'all';

  var layers = group.topologicalSortSourceBasedBfs();

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

  var layers = group.topologicalSortSourceBasedBfs([ a, b, c, d, e, f, g, h, i ]);

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

  test.case = 'c, e';

  var layers = group.topologicalSortSourceBasedBfs([ c, e ]);

  var expected =
  [
    [ 'c', 'e' ],
    [ 'b', 'a', 'h' ],
    [ 'f', 'i' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  sys.finit();

}

//

function nodesAreConnectedDfs( test )
{

  test.case = 'setup';

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

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.exportInfo() );

  test.case = 'a';

  var connected = group.nodesAreConnectedDfs( a, a );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( a, b );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( a, e );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( a, g );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( a, f );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( a, g );
  test.identical( connected, false );

  test.case = 'g';

  var connected = group.nodesAreConnectedDfs( g, g );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( g, f );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( g, b );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( f, g );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( f, f );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( f, b );
  test.identical( connected, false );

}

//

function groupByConnectivityDfs( test )
{

  test.case = 'setup';

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

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
  logger.log( group.exportInfo() );

  test.case = 'explicit';

  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  var groups = group.groupByConnectivityDfs( group.nodes );
  test.identical( groups.length, 3 );
  test.identical( groups, expected );

  test.case = 'implicit';

  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  var groups = group.groupByConnectivityDfs();
  test.identical( groups.length, 3 );
  test.identical( groups, expected );

}

//

function groupByStrongConnectivityDfs( test )
{

  test.case = 'setup';

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

  var sys = new _.AbstractGraphSystem();
  var group = sys.groupMake();

  // 3, 2, 5, 1 -> c, b, e, a

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  var expected = [ [ j ], [ f ], [ i, h ], [ g ], [ a, b, e, c ], [ d ] ];
  var groups = group.groupByStrongConnectivityDfs( group.nodes );
  test.identical( groups, expected );

  var expectedIds = [ [ 10 ], [ 6 ], [ 9, 8 ], [ 7 ], [ 1, 2, 5, 3 ], [ 4 ] ];
  var groupsIds = groups.map( ( nodes ) => group.nodesToIds( nodes ) );
  test.identical( groupsIds, expectedIds );

}

//

var Self =
{

  name : 'Tools/mid/AbstractGraph',
  silencing : 1,

  tests :
  {

    makeByNodes,
    clone,
    reverse,

    sinksAmong,
    sourcesAmong,
    lookDfs,
    lookBfs,

    topologicalSortDfs,
    topologicalSortSourceBasedBfs,

    nodesAreConnectedDfs,
    groupByConnectivityDfs,
    groupByStrongConnectivityDfs,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
