( function _NodesGroup_s_( ) {

'use strict';

/**
 * @classdesc Class to operate graph as group of nodes.
 * @class wAbstractNodesGroup
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph
 */

let _ = _global_.wTools;
let Parent = null;
let ContainerAdapter = _.containerAdapter.Abstract;
let SetContainerAdapter = _.containerAdapter.Set;
let ArrayContainerAdapter = _.containerAdapter.Array;
let _Vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let _VectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let _VectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let _VectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let Self = function wAbstractNodesGroup( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractNodesGroup';
Self.shortName2 = 'Group';

// --
// functor
// --

function _Vectorize_functor_functor( originalVectorize )
{
  _.assert( _.routineIs( originalVectorize ) )
  return function vectorize( r )
  {
    _.assert( _.routineIs( r ) );
    _.assert( arguments.length === 1 );

    let result = originalVectorize( r );
    _.assert( _.routineIs( result ) );
    if( r.properties && r.input === 'Node' )
    {
      result.input = '(*Node)';
      result.properties = result.properties || Object.create( null );
      if( result.properties.forCollection === undefined )
      result.properties.forCollection = true;
    }
    return result;
  }
}

let Vectorize = _Vectorize_functor_functor( _Vectorize );
let VectorizeAll = _Vectorize_functor_functor( _VectorizeAll );
let VectorizeAny = _Vectorize_functor_functor( _VectorizeAny );
let VectorizeNone = _Vectorize_functor_functor( _VectorizeNone );

// --
// routine
// --

function init( o )
{
  let group = this;

  // _.assert( _.mapIs( o ) );
  // _.assert( o.sys instanceof _.graph.AbstractGraphSystem );

  // group[ nodesSymbol ] = sys.ContainerAdapterFrom( new Set );

  _.workpiece.initFields( group );
  Object.preventExtensions( group );

  // _.assert( sys.ContainerAdapterIs( group.nodes ) && group.nodes.length === 0 );

  if( o )
  group.copy( o );

  group.form();

  return group;
}

//

function finit()
{
  let group = this;
  let sys = group.sys;

  // if( group.collections.length )
  // debugger;
  // _.assert( 0, 'not tested' );

  let collections = _.make( group.collections );
  _.empty( group.collections );

  _.assert( collections !== group.collections );
  _.assert( group.collections.length === 0 );

  collections.forEach( ( collection ) =>
  {
    // collection.group = null;
    collection.finit();
  });

  group.unform();
  _.Copyable.prototype.finit.call( group );
}

//

function isUsed()
{
  let group = this;
  let sys = group.sys;
  return group.collections.length > 0;
}

//

function form()
{
  let group = this;
  let sys = group.sys;
  _.assert( group.sys instanceof group.System );
  _.arrayAppendOnceStrictly( group.sys.groups, group );
}

//

function unform()
{
  let group = this;
  let sys = group.sys;

  _.assert( !group.isUsed() );

  // group.nodesDelete();
  _.arrayRemoveOnceStrictly( group.sys.groups, group );
}

//

function clone()
{
  let group = this;
  let sys = group.sys;
  let group2 = _.Copyable.prototype.clone.apply( group, arguments );
  return group2;
}

// --
// reverse
// --

function directSet( val )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( val ) );

  val = !!val;

  if( group[ directSymbol ] === undefined )
  {
    group[ directSymbol ] = val;
    return val;
  }

  group.reverse( val );

  return val;
}

//

function reverse( val )
{
  let group = this;
  let sys = group.sys;

  if( val === undefined )
  val = !group.direct;
  else
  val = !!val;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group.direct === val )
  return group;

  _.assert
  (
    val || _.routineIs( group.onInNodesGet ),
    () => 'Expects defined callback {-onInNodesGet-}. Define it or call method cacheInNodesFromOutNodesOnce before reversing graph.'
  );
  // if( !val && !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce();

  let onOutNodesGet = group.onOutNodesGet;
  let onInNodesGet = group.onInNodesGet;

  _.assert( _.routineIs( onOutNodesGet ), 'Direct neighbour nodes getter is not defined' );
  _.assert( _.routineIs( onInNodesGet ), 'Reverse neighbour nodes getter is not defined' );

  group.onOutNodesGet = onInNodesGet;
  group.onInNodesGet = onOutNodesGet;

  group[ directSymbol ] = val;
  return group;
}

//

function cacheInNodesFromOutNodesInvalidate()
{
  let group = this;
  let sys = group.sys;

  _.assert( 0, 'not tested' );

  if( group._inNodesCacheHash )
  group._inNodesCacheHash.clear();
  group._inNodesCacheHash = null;

}

//

function cacheInNodesFromOutNodesOnce( nodes )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group._inNodesCacheHash )
  return group._inNodesCacheHash;

  return group.cacheInNodesFromOutNodesUpdate( nodes );
}

var routine = cacheInNodesFromOutNodesOnce;
var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

function cacheInNodesFromOutNodesUpdate( nodes )
{
  let group = this;
  let sys = group.sys;

  // _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( arguments.length === 1 );

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  if( !group.onInNodesGet )
  group.onInNodesGet = group.inNodesFromGroupCache;

  if( !group._inNodesCacheHash )
  group._inNodesCacheHash = new HashMap();

  nodes.each( ( node1 ) =>
  {
    group._inNodesCacheHash.set( node1, sys.ContainerAdapterFrom( new Set ) );
  });

  nodes.each( ( node1 ) =>
  {
    group.cacheInNodesFromOutNodesUpdateNode( node1 );
  });

  return group._inNodesCacheHash;
}

var routine = cacheInNodesFromOutNodesUpdate;
var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

function cacheInNodesFromOutNodesUpdateNode( node )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( !!group.nodeIs( node ) );
  _.assert( !!group.onInNodesGet );
  _.assert( !!group._inNodesCacheHash );

  if( !group._inNodesCacheHash.has( node ) )
  group._inNodesCacheHash.set( node, sys.ContainerAdapterFrom( new Set ) );

  let directNeighbours = group.nodeOutNodesFor( node );
  directNeighbours = sys.ContainerAdapterFrom( directNeighbours );
  directNeighbours.each( ( node2 ) =>
  {
    let inNodes = group._inNodesCacheHash.get( node2 );
    if( !inNodes )
    {
      inNodes = sys.ContainerAdapterFrom( new Set );
      group._inNodesCacheHash.set( node2, inNodes );
    }
    _.assert( !!inNodes, `Cant retrive in nodes of ${group.nodeToQualifiedName( node2 )} from cache` );
    inNodes.push( node );
  });

  return group._inNodesCacheHash;
}

//

function cachesInvalidate()
{
  let group = this;
  let sys = group.sys;
  debugger;
  _.assert( 'not tested' );
  group.cacheInNodesFromOutNodesInvalidate();
  return group;
}

// --
// exporter
// --

function optionsExport()
{
  let group = this;
  let sys = group.sys;
  let result = Object.create( null );
  result.onNodeNameGet = group.onNodeNameGet;
  result.onNodeEvaluate = group.onNodeEvaluate;
  result.onNodeIs = group.onNodeIs;
  result.onOutNodesGet = group.onOutNodesGet;
  result.onInNodesGet = group.onInNodesGet;
  return result
}

//

function structureExport( o )
{
  let group = this;
  let sys = group.sys;

  o = _.routineOptions( structureExport, arguments );

  // if( o.nodes === null )
  // o.nodes = group.nodes;
  // else
  o.nodes = group.asNodesAdapter( o.nodes );

  let result = Object.create( null );
  result.nodes = group.nodesDataExport( o.nodes );

  return result;
}

structureExport.defaults =
{
  nodes : null,
}

//

/**
 * @summary Returns string with information about nodes relation.
 * @description
 * For example we have three nodes 'a','b','c' with ids: 1,2,3.
 * Edges between nodes: 'a','b' and 'b','c'.
 * Relation info will look like:
 *  1 : 2
 *  2 : 3
 *  3 :
 * @function infoExport
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function infoExport( o )
{
  let group = this;
  let sys = group.sys;

  o = _.routineOptions( infoExport, arguments );

  // if( o.nodes === null )
  // o.nodes = group.nodes;
  // else
  o.nodes = group.asNodesAdapter( o.nodes );

  let result = group.nodesInfoExport( o.nodes, o );

  return result;
}

var routine = infoExport;

routine.defaults =
{
  verbosity : 2,
  nodes : null,
}

routine.properties =
{
  forCollection : 1,
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`.
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorWithNode
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDescriptorWithNode( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorWithNode.apply( sys, arguments );
}

//

function nodeDescriptorWith( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorWith.apply( sys, arguments );
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`. Creates new descriptor if it doesn't exist.
 * @param {Number} node Node.
 * @function nodeDescriptorObtain
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDescriptorObtain( node )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorObtain.apply( sys, arguments );
}

//

function nodeDescriptorDelete( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorDelete.apply( sys, arguments );
}

// --
// node
// --

// /**
//  * @summary Returns true if group has provided node. Takes node handle as argument.
//  * @param {Object} node Node descriptor.
//  * @function hasNode
//  * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
//  */
//
// function hasNode( node )
// {
//   let group = this;
//   let sys = group.sys;
//   _.assert( !!group.nodeIs( node ) ); debugger;
//   return group.nodes.has( node );
// }

//

/**
 * @summary Returns true if provided entity `node` is a node.
 * @param {Object} node Node descriptor.
 * @function nodeIs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeIs( node )
{
  let group = this;
  let sys = group.sys;
  return group.onNodeIs( node );
}

var routine = nodeIs;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeIndegree( node )
{
  let group = this;
  let sys = group.sys;
  let nodes = group.nodeInNodesFor( node );
  return nodes.length;
}

var routine = nodeIndegree;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeOutdegree( node )
{
  let group = this;
  let sys = group.sys;
  let nodes = group.nodeOutNodesFor( node );
  return nodes.length;
}

var routine = nodeOutdegree;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeDegree( node )
{
  let group = this;
  let sys = group.sys;
  let nodes1 = group.nodeInNodesFor( node );
  let nodes2 = group.nodeOutNodesFor( node );
  return nodes1.length + nodes2.length;
}

var routine = nodeDegree;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeOutNodesFor( node )
{
  let group = this;
  let sys = group.sys;
  _.assert( !!group.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  let result = sys.ContainerAdapterFrom( group.onOutNodesGet( node ) );
  _.assert( sys.ContainerIs( result ), () => `Cant retrive out nodes of ${group.nodeToQualifiedNameTry( node )}` );
  return result;
}

var routine = nodeOutNodesFor;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeInNodesFor( node )
{
  let group = this;
  let sys = group.sys;
  _.assert( !!group.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  let result = sys.ContainerAdapterFrom( group.onInNodesGet( node ) );
  _.assert( sys.ContainerIs( result ), () => `Cant retrive out nodes of ${group.nodeToQualifiedNameTry( node )}` );
  return result;
}

var routine = nodeInNodesFor;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeOutNodesIdsFor( node )
{
  let group = this;
  let sys = group.sys;

  _.assert( !!group.nodeIs( node ) );
  _.assert( arguments.length === 1 );

  let result = group.nodesToIds( group.onOutNodesGet( node ) );

  _.assert( sys.ContainerIs( result ) );
  return result;
}

var routine = nodeOutNodesIdsFor;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeInNodesIdsFor( node )
{
  let group = this;
  let sys = group.sys;

  _.assert( !!group.nodeIs( node ) );
  _.assert( arguments.length === 1 );

  let result = group.nodesToIds( group.onInNodesGet( node ) );

  _.assert( sys.ContainerIs( result ) );
  return result;
}

var routine = nodeInNodesIdsFor;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

// function nodeRefNumber( nodeId )
// {
//   let group = this;
//   let sys = group.sys;
//
//   _.assert( arguments.length === 1 );
//   _.assert( !!nodeId, 'Expects node or node id' );
//   _.assert( 'not tested' );
//
//   if( !sys.idIs( nodeId ) )
//   {
//     nodeId = group.nodeToId( nodeId );
//   }
//
//   let descriptor = group.nodeDescriptorWithNode( nodeId );
//
//   if( !descriptor )
//   if( sys.idToNodeHash.has( nodeId ) )
//   return 1;
//   else
//   return 0;
//
//   _.assert( descriptor.count >= 0 );
//
//   return descriptor.count;
// }

//

function nodeDataExport( node )
{
  let group = this;
  let sys = group.sys;
  _.assert( group.nodeIs( node ) );

  let result = Object.create( null );
  result.id = group.nodeToId( node );
  result.outNodeIds = group.nodesToIdsTry( group.nodeOutNodesFor( node ) );

  return result;
}

var routine = nodeDataExport;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeInfoExport( node, opts )
{
  let group = this;
  let sys = group.sys;
  if( group.onNodeInfoExport )
  return group.onNodeInfoExport( node, o );

  let name = group.nodeToName( node );
  let outNames = group.nodesToNames( group.nodeOutNodesFor( node ) );

  let result = name + ' : ' + outNames.join( ' ' );
  return result;
}

var routine = nodeDataExport;
var properties = routine.properties = Object.create( null );
routine.input =
`
(
  Node
  Map
)
`;

//

function nodesInfoExport( nodes, opts )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 )

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  let result = nodes.map( ( node ) => group.nodeInfoExport( node, opts ) );

  result = result.join( '\n' );
  return result;
}

var routine = nodesInfoExport;
var properties = routine.properties = Object.create( null );
routine.input =
`
(
  [ [ Set, Array ] of (*Node), Node ] :: nodes
  Map :: opts
)
`;

//

function rootsExportInfoTree( roots, opts )
{
  let group = this;
  let sys = group.sys;
  let result = '';
  let prevIt;
  let lastNodes;
  let tab;

  roots = group._routineArguments1( roots );
  opts = _.routineOptions( rootsExportInfoTree, opts );

  if( opts.onNodeName === null )
  opts.onNodeName = defaultOnNodeName;

  _.assert( opts.dtab1.length === opts.dtab2.length );
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );

  let l = roots.length-1;
  _.assert( _.intIs( l ) );
  roots.each( ( node, i ) =>
  {
    _.assert( _.intIs( i ) );
    lastNodes = new Set;
    tab = '';

    if( opts.rootsDelimiting && i > 0 )
    result += opts.linePrefix + opts.dtab1 + opts.linePostfix;

    prevIt = { level : Infinity, path : [] };
    group.lookDfs
    ({
      roots : node,
      onBegin : handleBegin,
      onUp : handleUp1,
      onDown : handleDown1,
      fast : 0,
      revisiting : 1,
    });

    if( i === l )
    lastNodes.add( node );

    prevIt = { level : 0, path : [] };
    if( i === l )
    prevIt.node = node;
    group.lookDfs
    ({
      roots : node,
      onBegin : handleBegin,
      onUp : handleUp2,
      onDown : handleDown2,
      fast : 0,
      revisiting : 1,
    });

  });

  return result;

  /* */

  function defaultOnNodeName( node )
  {
    return group.nodeToName( node );
  }

  /* */

  function handleBegin( it )
  {
  }

  /* */

  function handleUp1( node, it )
  {
  }

  /* */

  function handleDown1( node, it )
  {
    if( !it.iterator.continue || !it.continue || !it.continueUp || !it.continueNode )
    {
      debugger;
      return;
    }
    let dLevel = it.level - prevIt.level;
    if( dLevel < 0 && prevIt.node !== undefined )
    lastNodes.add( prevIt.node );
    prevIt = it;
  }

  /* */

  function handleUp2( node, it )
  {

    if( opts.onUp )
    opts.onUp( node, it );
    if( !it.iterator.continue || !it.continue || !it.continueUp || !it.continueNode )
    {
      debugger;
      return;
    }

    let isLast = lastNodes.has( prevIt.node );
    let dLevel = it.level - prevIt.level;
    let name = opts.onNodeName( node );

    if( dLevel < 0 )
    tab = tab.substring( 0, tab.length + dLevel*opts.dtab1.length );

    if( dLevel > 0 )
    tab += isLast ? opts.dtab2 : opts.dtab1;

    let tab2 = tab;

    tab2 = opts.tabPrefix + tab2 + opts.tabPostfix;

    result += opts.linePrefix + tab2 + name + opts.linePostfix;

    prevIt = it;
  }

  /* */

  function handleDown2( node, it )
  {
    if( opts.onDown )
    opts.onDown( node, it );
  }

}

rootsExportInfoTree.defaults =
{
  linePrefix : ' ',
  linePostfix : '\n',
  tabPrefix : '',
  tabPostfix : '+-- ',
  dtab1 : '| ',
  dtab2 : '  ',
  rootsDelimiting : 1,
  onNodeName : null,
  onUp : null,
}

//

/**
 * @summary Returns qualified name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToQualifiedName
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToQualifiedName( node )
{
  let group = this;
  let sys = group.sys;
  let result;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( arguments.length === 1 );

  if( group.onNodeQualifiedNameGet === null )
  result = 'node::' + group.nodeToName( node );
  else
  result = group.onNodeQualifiedNameGet( node );

  _.assert( _.primitiveIs( result ) && result !== undefined, 'Cant get qualified name for the node' );

  return String( result );
}

//

/**
 * @summary Try to return qualified name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToQualifiedNameTry
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToQualifiedNameTry( node )
{
  let group = this;
  let sys = group.sys;
  try
  {
    let result = group.nodeToQualifiedName( node );
    return result;
  }
  catch( err )
  {
    return '';
  }
}

//

/**
 * @summary Returns name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToName
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToName( node )
{
  let group = this;
  let sys = group.sys;
  let result;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( arguments.length === 1 );

  if( group.onNodeNameGet === null )
  result = group.nodeNameFromGetterId( node );
  else
  result = group.onNodeNameGet( node );

  _.assert( _.primitiveIs( result ) && result !== undefined, 'Cant get name for the node' );

  return String( result );
}

var routine = nodeToName;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeToNameTry( node )
{
  let group = this;
  let sys = group.sys;
  if( !group.nodeIs( node ) )
  return undefined;
  _.assert( arguments.length === 1 );
  return group.nodeToName( node );
}

var routine = nodeToNameTry;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//
//
// /**
//  * @summary Returns id of node. Takes single argument - a node.
//  * @description Returns undefined if can't get id of provided node.
//  * @param {Object} node Node descriptor.
//  * @function nodeToIdTry
//  * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
//  */
//
// function nodeToIdTry( node )
// {
//   let group = this;
//   let sys = group.sys;
//   return sys.nodeToIdTry( node );
// }
//
// //
//
// /**
//  * @summary Returns id of node. Takes single argument - a node.
//  * @param {Object} node Node descriptor.
//  * @function nodeToId
//  * @throws {Error} If can't get id of provided node.
//  * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
//  */
//
// function nodeToId( node )
// {
//   let group = this;
//   let sys = group.sys;
//
//   if( group.onNodeIdGet )
//   return group.onNodeIdGet( node );
//
//   return sys.nodeToId( node );
// }
//
// //
//
// function idToNodeTry( nodeId )
// {
//   let group = this;
//   let sys = group.sys;
//   return sys.idToNodeTry( nodeId );
// }
//
// //
//
// function idToNode( nodeId )
// {
//   let group = this;
//   let sys = group.sys;
//   return sys.idToNode( nodeId );
// }
//
// //
//
// function idToName( nodeId )
// {
//   let group = this;
//   let sys = group.sys;
//   let node = group.idToNode( nodeId );
//   return group.nodeToName( node );
// }

// --
// filter
// --

function leastIndegreeAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = Infinity;

  nodes.each( ( node ) =>
  {
    let d = group.nodeIndegree( node );
    if( d < result )
    result = d;
  });

  if( result === Infinity )
  result = 0;

  return result;
}

var routine = leastIndegreeAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function mostIndegreeAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = 0;

  nodes.each( ( node ) =>
  {
    let d = group.nodeIndegree( node );
    if( d > result )
    result = d;
  });

  return result;
}

var routine = mostIndegreeAmong;
var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function leastOutdegreeAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  // if( !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce( nodes );

  let result = Infinity;

  nodes.each( ( node ) =>
  {
    let d = group.nodeOutdegree( node );
    if( d < result )
    result = d;
  });

  if( result === Infinity )
  result = 0;

  return result;
}

var routine = leastOutdegreeAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function mostOutdegreeAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  // if( !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce( nodes );

  let result = 0;

  nodes.each( ( node ) =>
  {
    let d = group.nodeOutdegree( node );
    if( d > result )
    result = d;
  });

  return result;
}

var routine = mostOutdegreeAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function leastIndegreeOnlyAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.leastIndegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeIndegree( node ) === degree ? node : undefined );
  return result;
}

var routine = leastIndegreeOnlyAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function mostIndegreeOnlyAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.mostIndegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeIndegree( node ) === degree ? node : undefined );
  return result;
}

var routine = mostIndegreeOnlyAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function leastOutdegreeOnlyAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.leastOutdegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeOutdegree( node ) === degree ? node : undefined );
  return result;
}

var routine = leastOutdegreeOnlyAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function mostOutdegreeOnlyAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.mostOutdegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeOutdegree( node ) === degree ? node : undefined );
  return result;
}

var routine = mostOutdegreeOnlyAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function sourcesOnlyAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = nodes.filter( ( node ) => group.nodeInNodesFor( node ).length === 0 ? node : undefined );

  return result;
}

var routine = sourcesOnlyAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function sinksOnlyAmong( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = nodes.filter( ( node ) => group.nodesOutNodesFor( node ).length === 0 ? node : undefined );

  return result;
}

var routine = sinksOnlyAmong;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

// --
// helper
// --

/**
 * @summary Find all sources for graph specified with roots. Algorithm can handle cycled graph.
 * @param {Container of Node | Node} dstNodes Container to write result.
 * @param {Container of Node | Node} srcNodes Container of nodes to look into.
 *
 * @function sourcesFromNodes
 * @return {Conainer of Node} Returns cotainer of nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function sourcesFromNodes( dstNodes, srcNodes )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcNodes ] = group._routineArguments2( ... arguments );

  if( dstNodes.original === srcNodes.original )
  {
    if( !group.onInNodesGet && dstNodes.length )
    group.cacheInNodesFromOutNodesOnce( srcNodes );
    srcNodes = dstNodes.make();
    dstNodes.filter( dstNodes, ( node ) => group.nodeIndegree( node ) === 0 ? node : undefined );
  }

  let collection = group.nodesStronglyConnectedCollection( srcNodes );
  collection.nodes.each( ( node ) =>
  {
    if( collection.group.nodeIndegree( node ) === 0 )
    dstNodes.appendContainerOnce( node.originalNodes );
  });
  collection.finit();

  return dstNodes.original;
}

//

/**
 * @summary Find all sources for graph specified with roots. Algorithm can handle cycled graph.
 * @param {Container of Node | Node} dstNodes Container to write result.
 * @param {Container of Node | Node} srcNodes Container of roots to look into.
 *
 * @function sourcesFromRoots
 * @return {Conainer of Node} Returns cotainer of nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function sourcesFromRoots( dstNodes, srcRoots )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcRoots ] = group._routineArguments2( ... arguments );

  let same = dstNodes.original === srcRoots.original;
  let srcNodes = group.rootsToAll( null, srcRoots );

  if( same )
  {
    if( !group.onInNodesGet || group._inNodesCacheHash )
    group.cacheInNodesFromOutNodesUpdate( srcNodes );
    dstNodes.filter( dstNodes, ( node ) => group.nodeIndegree( node ) === 0 ? node : undefined );
  }

  group.sourcesFromNodes( dstNodes, srcNodes );

  return dstNodes.original;
}

//

/**
 * @summary Find all nodes reachable from specified roots.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function rootsToAllReachable
 * @return {Array of Node|Set of Node} Returns cotainer of nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function rootsToAllReachable( dstNodes, srcRoots )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcRoots ] = group._routineArguments2( ... arguments );

  group.lookDfs({ roots : srcRoots, onUp : onUp });

  return dstNodes.original;

  function onUp( node )
  {
    dstNodes.appendOnce( node );
  }

}

//

/**
 * @summary Find all nodes either reachable from specified roots or nodes which can reach specified.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function rootsToAll
 * @return {Array of Node|Set of Node} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function rootsToAll( dstNodes, srcRoots )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcRoots ] = group._routineArguments2( ... arguments );

  if( srcRoots === dstNodes )
  srcRoots = srcRoots.make();

  // let cacheRequired = group.direct && !group.onInNodesGet;
  // if( cacheRequired )
  // group.cacheInNodesFromOutNodesOnce( srcRoots );

  group.lookDfs({ roots : srcRoots, onUp : onUp });
  if( !group.direct || group.onInNodesGet )
  {

    if( !group.onInNodesGet || group._inNodesCacheHash )
    group.cacheInNodesFromOutNodesUpdate( srcRoots );

    group.reverse();
    group.lookDfs({ roots : srcRoots, onUp : onUp });
    group.reverse();

    if( !group.onInNodesGet || group._inNodesCacheHash )
    group.cacheInNodesFromOutNodesUpdate( dstNodes );

  }

  // if( cacheRequired )
  // group.cacheInNodesFromOutNodesUpdate( dstNodes );

  return dstNodes.original;

  function onUp( node )
  {
    dstNodes.appendOnce( node );
    // group.nodeAddOnce( node );
  }

}

//

/**
 * @summary Put node in a container if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function asNodes
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function asNodes( nodes )
{
  let group = this;
  let sys = group.sys;

  if( sys.ContainerIs( nodes ) )
  return nodes;

  _.assert( group.nodeIs( nodes ) );
  nodes = new Set([ nodes ]);
  return nodes;
}

var routine = asNodes;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

/**
 * @summary Put node in a set if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function asNodesPreferSet
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function asNodesPreferSet( nodes )
{
  let group = this;
  let sys = group.sys;

  if( sys.ContainerIs( nodes ) )
  {
    return nodes;
  }

  // if( sys.ContainerIsSet( nodes ) )
  // {
  //   return nodes;
  // }
  //
  // if( sys.ContainerIs( nodes ) )
  // {
  //   nodes = sys.ContainerAdapterFrom( nodes );
  //   return nodes.toSet().original;
  // }

  _.assert( group.nodeIs( nodes ) );
  nodes = new Set([ nodes ]);
  return nodes;
}

var routine = asNodesPreferSet;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

/**
 * @summary Put node in a set if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function asNodesPreferArray
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function asNodesPreferArray( nodes )
{
  let group = this;
  let sys = group.sys;

  if( sys.ContainerIs( nodes ) )
  {
    return nodes;
  }

  // if( sys.ContainerIsArray( nodes ) )
  // {
  //   return nodes;
  // }
  //
  // if( sys.ContainerIs( nodes ) )
  // {
  //   _.assert( 0, 'not tested' )
  //   nodes = sys.ContainerAdapterFrom( nodes );
  //   return nodes.toArray().original;
  // }

  _.assert( group.nodeIs( nodes ) );
  nodes = new Array([ nodes ]);
  return nodes;
}

var routine = asNodesPreferArray;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

/**
 * @summary Put node in a container if not put yet in a container. Put the containe in adapter.
 * @param {Array|Set|Node|ContainerAdapter} nodes Array of nodes.
 *
 * @function asNodesAdapter
 * @return {ContainerAdapter} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function asNodesAdapter( nodes )
{
  let group = this;
  let sys = group.sys;
  return sys.ContainerAdapterFrom( group.asNodes( nodes ) );
}

var routine = asNodesAdapter;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

function nodeFrom( node )
{
  let group = this;
  let sys = group.sys;
  let result = node;
  if( group.onNodeFrom )
  result = group.onNodeFrom( node );
  _.assert( !!group.nodeIs( result ), () => `Cant get node from ${_.strShort( result )}` );
  return result;
}

//

function nodesFrom( nodes )
{
  let group = this;
  let sys = group.sys;
  let result = _.map( nodes, ( node ) => group.nodeFrom( node ) );
  return result;
}

var routine = nodesFrom;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 0;

//

function _routineArguments1( srcNodes )
{
  let group = this;
  let sys = group.sys;

  // if( srcNodes === undefined )
  // {
  //   srcNodes = group.nodes;
  // }
  // else
  // {
    srcNodes = group.asNodes( srcNodes );
  // }

  srcNodes = sys.ContainerAdapterFrom( srcNodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( sys.ContainerIs( srcNodes ) );

  return srcNodes;
}

//

function _routineArguments2( dstNodes, srcNodes )
{
  let group = this;
  let sys = group.sys;

  if( group.nodeIs( dstNodes ) )
  {
    dstNodes = group.asNodes( dstNodes );
  }

  if( srcNodes === undefined )
  {
    if( dstNodes )
    srcNodes = dstNodes;
    // else
    // srcNodes = group.nodes;
  }
  else
  {
    srcNodes = group.asNodes( srcNodes );
  }

  srcNodes = sys.ContainerAdapterFrom( srcNodes );

  if( dstNodes === null )
  dstNodes = _.makeEmpty( srcNodes.original );
  dstNodes = sys.ContainerAdapterFrom( dstNodes );

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( sys.ContainerIs( dstNodes ) );
  _.assert( sys.ContainerIs( srcNodes ) );

  return [ dstNodes, srcNodes ]
}

// --
// traverser
// --

/**
 * @summary Performs breadth-first search on graph.
 * @param {Object} o Options map.
 * @param {Array|Object} o.roots Nodes to use as start point.
 * @param {Function} o.onUp Handler called before visiting each level.
 * @param {Function} o.onDown Handler called after visiting each level.
 * @param {Function} o.onNode Handler called for each node.
 *
 * @example
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c ); // add connections between node a and b, c nodes
 * c.nodes.push( d ); // add connection between node c and d
 *
 * //declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // breadth-first search for reachable nodes using provided node as start point
 *
 * var layers = group.lookBfs({ roots : a }); // node 'a' is start node
 * layers = layers.map( ( nodes ) => group.nodesToNames( nodes ) ) // extract name of nodes from node handles to simplify the output
 * console.log( layers )
 *
 * @function lookBfs
 * @return {Array} Returns array of layers that are reachable from provided nodes `o.roots`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function lookBfs( o )
{
  let group = this;
  let sys = group.sys;

  _.routineOptions( lookBfs, o );

  o.roots = group.asNodesPreferSet( o.roots );
  o.roots = group.asNodesAdapter( o.roots );
  o.roots.once( o.roots );

  let allDirect = o.left ? 'allLeft' : 'allRight';
  let allRevert = o.left ? 'allRight' : 'allLeft';

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = o.revisiting === 2 ? new Array() : new Set();
  if( o.visitedContainer )
  o.visitedContainer = sys.ContainerAdapterFrom( o.visitedContainer );

  if( Config.debug )
  {
    _.assert( arguments.length === 1 );
    _.assert( group.nodesAreAll( o.roots ) );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( o.roots.all( ( node ) => group.nodeIs( node ) ) );
    _.assert( !o.visitedContainer || o.revisiting !== 2 || _.arrayIs( o.visitedContainer.original ) )
  }

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.layers = [];
  iterator.level = 0;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.continueNode = true;
  iterator.visited = false;
  iterator.result = iterator.layers;
  iterator.options = o;

  if( o.onBegin )
  o.onBegin( iterator );

  visit( o.roots, iterator );

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visit( nodes, it )
  {
    let nodes2 = sys.ContainerAdapterFrom( new Set );
    let nodesStatus = new HashMap;

    /*
      0 - not visiting
      1 - not including
      2 - not going up
      3 - visit, include, go up
    */

    if( o.onLayerUp )
    o.onLayerUp( _.setFrom( nodes ), it );

    let itContinueUp = it.continueUp;
    let itContinueNode = it.continueNode;

    if( it.iterator.continue )
    nodes[ allDirect ]( ( node, k ) =>
    {

      it.visited = false;
      if( o.revisiting === 2 )
      {
        it.visited = o.visitedContainer.count( node );
        if( it.visited > 1 )
        {
          nodesStatus.set( node, [ false, false, true ] );
          return true;
        }
      }
      else if( o.revisiting < 2 )
      {
        if( o.visitedContainer.has( node ) )
        {
          it.visited = true;
          nodesStatus.set( node, [ false, false, true ] );
          return true;
        }
      }

      if( o.onUp )
      o.onUp( node, it );

      if( it.continueNode )
      if( o.onNode )
      o.onNode( node, it );

      if( !it.continueNode )
      it.continueUp = false;

      if( it.continueUp )
      {
        if( o.revisiting === 2 )
        {
          if( !it.visited )
          {
            nodes2.append( node );
          }
          if( o.visitedContainer )
          o.visitedContainer.push( node );
        }
        else
        {
          nodes2.append( node );
          if( o.visitedContainer )
          o.visitedContainer.push( node );
        }
      }

      nodesStatus.set( node, [ it.continueUp, it.continueNode, it.visited ] );

      it.continueNode = itContinueNode;
      it.continueUp = itContinueUp;

      return it.iterator.continue;
    });

    it.continueUp = itContinueUp;
    it.continueNode = itContinueNode;

    if( !it.continueNode )
    it.continueUp = false;

    if( nodes2.length )
    visitUp( nodes2, it );

    /* */

    nodes[ allRevert ]( ( node, k ) =>
    {
      [ it.continueUp, it.continueNode, it.visited ] = nodesStatus.get( node );

      if( !it.continueNode )
      return true;

      if( o.onDown )
      o.onDown( node, it );

      return true;
    });

    if( o.onLayerDown )
    o.onLayerDown( nodes2, it );

    it.continueUp = true;
  }

  /* */

  function visitUp( nodes2, it )
  {
    let nodes3 = sys.ContainerAdapterFrom( new Array );

    it.layers.push( nodes2.original );

    if( !it.iterator.continue || !it.continueUp )
    return;

    nodes2.each( ( node ) =>
    {
      let outNodes = group.nodeOutNodesFor( node );
      nodes3.appendContainerOnce( outNodes );
    });

    let level = it.level;
    let continueNode = it.continueNode;
    it.level += 1;
    visit( nodes3, it );
    it.level = level;
    it.continueNode = continueNode;

  }

}

lookBfs.defaults =
{

  roots : null,
  visitedContainer : null,

  left : 1, /* qqq xxx : cover option left */
  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,
  onLayerUp : null,
  onLayerDown : null,

}

//

/**
 * @summary Performs depth-first search on graph.
 * @param {Object} o Options map.
 * @param {Array|Object} o.roots Nodes to use as start point.
 * @param {Function} o.onUp Handler called before visiting each level.
 * @param {Function} o.onDown Handler called after visiting each level.
 *
 * @example
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c ); // add connections between node a and b, c nodes
 * c.nodes.push( d ); // add connection between node c and d
 *
 * //declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // breadth-first search for reachable nodes using provided node as start point
 *
 * var layers = group.lookDfs({ roots : a }); // node 'a' is start node
 * layers = layers.map( ( nodes ) => group.nodesToNames( nodes ) ) // extract name of nodes from node handles to simplify the output
 * console.log( layers )
 *
 * @function lookDfs
 * @return {Array} Returns array of layers that are reachable from provided nodes `o.roots`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function lookDfs( o )
{
  let group = this;
  let sys = group.sys;

  _.routineOptions( lookDfs, o );

  o.roots = group.asNodesAdapter( o.roots );

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = sys.ContainerMake();
  if( o.visitedContainer )
  o.visitedContainer = sys.ContainerAdapterFrom( o.visitedContainer );

  _.assert( arguments.length === 1 );
  _.assert( 0 <= o.revisiting && o.revisiting <= 3 );

  let allMethod = o.left ? 'allLeft' : 'allRight';

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.result = null;
  iterator.level = 0;
  iterator.options = o;
  iterator.visited = false;
  iterator.continueNode = true;

  if( o.onBegin )
  o.onBegin( iterator );

  if( o.fast )
  {
    o.roots[ allMethod ]( ( node, index ) =>
    {
      iterator.node = node;
      iterator.index = index;
      visitFast( iterator )
      return iterator.continue;
    });
  }
  else
  {
    o.roots[ allMethod ]( ( node, index ) =>
    {
      let it = Object.create( iterator );
      it.prev = iterator;
      it.node = node;
      it.index = index;
      it.visited = false;
      it.continueNode = true;
      it.level = 0;
      visitSlow( it );
      return it.iterator.continue;
    });
  }

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visitSlow( it )
  {

    if( o.revisiting < 3 )
    if( o.visitedContainer.has( it.node ) )
    {
      if( o.revisiting < 2 )
      return;
      it.continueUp = false;
      it.visited = true;
    }

    if( o.visitedContainer )
    o.visitedContainer.push( it.node );

    if( o.onUp )
    o.onUp( it.node, it );

    if( o.onNode )
    if( it.continueNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    {
      it.continueUp = false;

      if( o.visitedContainer )
      if( o.revisiting !== 1 && o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );

    }

    let level = it.level + 1;

    if( it.iterator.continue && it.continueUp )
    {
      let outNodes = group.nodeOutNodesFor( it.node );
      outNodes[ allMethod ]( ( node, n ) =>
      {

        let it2 = Object.create( iterator );
        it2.node = node;
        it2.index = n;
        it2.prev = it;
        it2.level = level;
        it2.visited = false;
        it2.continueNode = true;

        visitSlow( it2 );
        _.assert( !_.mapOwnKey( it2, 'continue' ) );

        return iterator.continue;
      });
    }

    if( o.onDown )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      o.visitedContainer.pop( it.node );
    }

  }

  /* */

  function visitFast( it )
  {
    if( o.revisiting < 3 )
    if( o.visitedContainer.has( it.node ) )
    {
      if( o.revisiting < 2 )
      return;
      it.continueUp = false;
      it.visited = true;
    }

    if( o.visitedContainer )
    o.visitedContainer.push( it.node );

    if( o.onUp )
    o.onUp( it.node, it );

    if( o.onNode )
    if( it.continueNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    {
      it.continueUp = false;

      if( o.visitedContainer )
      if( o.revisiting !== 1 && o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );

    }

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;
      let outNodes = group.nodeOutNodesFor( it.node );

      outNodes[ allMethod ]( ( node, n ) =>
      {
        it.node = node;
        it.index = n;
        it.level = level + 1;
        it.visited = false;
        visitFast( it );
        return it.iterator.continue;
      });

      it.level = level;
      it.node = node;
      it.index = index;
      it.visited = visited;
    }

    if( o.onDown )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      o.visitedContainer.pop( it.node );
    }

    it.continueNode = true;
    it.continueUp = true;
  }

}

lookDfs.defaults =
{

  roots : null,
  visitedContainer : null,

  left : 1, /* qqq xxx : cover option left */
  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,

}

//

function lookCfs( o )
{
  let group = this;
  let sys = group.sys;

  _.routineOptions( lookCfs, o );

  o.roots = group.asNodesAdapter( o.roots );
  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = sys.ContainerMake();
  if( o.visitedContainer )
  o.visitedContainer = sys.ContainerAdapterFrom( o.visitedContainer );

  if( Config.debug )
  {
    _.assert( arguments.length === 1 );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( group.nodesAreAll( o.roots ) );
  }

  let allMethod = o.left ? 'allLeft' : 'allRight';

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.visited = false;
  iterator.continueNode = true;
  iterator.result = null;
  iterator.level = 0;
  iterator.options = o;

  if( o.onBegin )
  o.onBegin( iterator );

  iterator.node = null;
  iterator.index = null;
  visit( iterator, o.roots );

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visit( it, outNodes )
  {

    if( o.visitedContainer )
    if( o.revisiting === 1 || o.revisiting === 2 )
    o.visitedContainer.push( it.node );

    let outNodes2 = outNodes;
    if( o.revisiting === 0 )
    outNodes2 = sys.ContainerAdapterFrom( [] );

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;
      let nodesStatus = new HashMap;

      /*
        0 - not visiting
        1 - not including
        2 - not going up
        3 - visit, include, go up
      */

      outNodes[ allMethod ]( ( node, n ) =>
      {
        let status = 3;

        let has = outNodes2.has( node );
        if( o.revisiting === 0 && !has )
        outNodes2.append( node );

        if( o.revisiting === 0 && has )
        return true;

        it.level = level;
        it.node = node;
        it.index = n;
        it.visited = false;

        if( o.revisiting < 3 )
        if( o.visitedContainer.has( node ) )
        {
          if( o.revisiting === 2 )
          {
            status = 2;
            it.visited = true;
            it.continueUp = false;
          }
          else
          {
            status = 0;
          }
        }

        if( o.revisiting < 2 && !status )
        {
          nodesStatus.set( node, [ status, it.visited ] );
          return true;
        }

        if( o.visitedContainer )
        if( o.revisiting !== 1 && o.revisiting !== 2 )
        o.visitedContainer.push( it.node );

        handleUp( it );

        if( !it.continueNode )
        {
          it.continueUp = false;
          if( o.visitedContainer )
          if( o.revisiting !== 1 && o.revisiting !== 2 )
          o.visitedContainer.pop();
        }

        if( status > 1 && !it.continueNode )
        {
          status = 1;
        }
        if( status > 2 && !it.continueUp )
        {
          status = 2;
        }
        nodesStatus.set( node, [ status, it.visited ] );

        if( !it.iterator.continue )
        return false;

        it.continueNode = true;
        it.continueUp = true;

        return true;

        function end( r )
        {
          nodesStatus.set( node, status );
          return r;
        }
      });

      outNodes2.all( ( node, n ) =>
      {
        let status;
        [ status, it.visited ] = nodesStatus.get( node );
        if( o.revisiting < 2 && !status )
        return true;

        it.level = level+1;
        it.index = n;
        it.node = node;

        it.continueNode = status > 1;
        it.continueUp = status > 2;

        visit( it, group.nodeOutNodesFor( it.node ) );

        if( !it.iterator.continue )
        return false;
        return true;
      });

      it.level = level;
      it.node = node;
      it.index = index;
      it.visited = visited;
    }

    // _.assert( it.node !== null ); /* xxx */
    if( o.onDown && it.node !== null )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      o.visitedContainer.popStrictly( it.node );
    }

    it.continueNode = true;
    it.continueUp = true;
  }

  /* */

  function handleUp( it )
  {

    if( o.onUp )
    o.onUp( it.node, it );

    if( it.continueNode )
    if( o.onNode )
    o.onNode( it.node, it );

  }

}

lookCfs.defaults =
{

  roots : null,
  visitedContainer : null,

  left : 1, /* qqq xxx : cover option left */
  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,

}

// --
// orderer
// --

/**
 * @summary Algorithm of linear ordering of directed acycled graph. Based on depth-first search.
 * @param {Array} nodes Array of nodes.
 *
 * @example
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c );
 * c.nodes.push( d );
 *
 * //declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * //topological sort based on depth first search
 *
 * var ordering = group.dagTopSortDfs();
 * ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
 * console.log( ordering );
 *
 * //[ 'b', 'd', 'c', 'a' ]
 *
 * @function dagTopSortDfs
 * @return {Array} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function dagTopSortDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let ordering = [];
  let visitedContainer = sys.ContainerAdapterFrom( new Set );

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node ) =>
  {
    if( visitedContainer.has( node ) )
    return;
    group.lookDfs
    ({
      roots : node,
      onDown : handleDown,
      revisiting : 0,
      visitedContainer : visitedContainer,
    });
  });

  _.assert( ordering.length === nodes.length, 'Seems input graph is not a DAG' );

  return ordering;

  /* */

  function handleDown( node, it )
  {
    let outNodes = group.nodeOutNodesFor( node );
    outNodes = outNodes.filter( ( node2 ) => !visitedContainer.has( node2 ) ? node2 : undefined );
    if( outNodes.length === 0 )
    ordering.push( node );
    // visitedContainer.push( node );
  }

}

var routine = dagTopSortDfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function each_pre( routine, args )
{
  let group = this;
  let sys = group.sys;
  let o = args[ 0 ];

  _.assert( arguments.length === 2 );
  _.assert( 0 <= args.length && args.length <= 2 );
  _.assert( args[ 1 ] === undefined || _.routineIs( args[ 1 ] ) )

  if( _.routineIs( args[ 0 ] ) && args[ 1 ] === undefined )
  o = { onUp : args[ 0 ] };
  else if( _.routineIs( args[ 1 ] ) )
  o = { nodes : args[ 0 ], onUp : args[ 1 ] };
  else if( o === undefined )
  o = {};

  _.routineOptions( routine, o );

  if( o.result === null )
  o.result = [];
  o.result = group.asNodesAdapter( o.result );

  // if( o.roots === undefined || o.roots === null )
  // o.roots = group.nodes;
  // else
  o.roots = group.asNodesAdapter( o.roots );

  if( Config.debug )
  {
    _.assert( 0 <= o.recursive && o.recursive <= 2 );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( group.nodesAreAll( o.roots ) );
  }

  if( o.method === null )
  o.method = this.lookCfs;
  if( _.strIs( o.method ) )
  {
    _.assert( _.routineIs( this[ o.method ] ), () => 'Unknown method ' + _.strQuote( o.method ) );
    o.method = this[ o.method ];
  }
  _.assert
  (
    _.routineIs( o.method ),
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookCfs, but got' + _.strType( o.method )
  );
  _.assert
  (
    o.method === group.lookBfs || o.method === group.lookDfs || o.method === group.lookCfs ,
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookCfs, but got' + _.strType( o.method )
  );

  return o;
}

function each_body( o )
{
  let group = this;
  let sys = group.sys;

  _.assertRoutineOptions( each, o );

  let o2 = _.mapOnly( o, o.method.defaults );

  o2.onNode = handleNode;
  o2.onUp = handleUp;
  o2.onDown = handleDown;
  o2.onBegin = handleBegin;
  o2.onEnd = handleEnd;
  _.assert( _.boolLike( o2.left ) );

  let r = o.method.call( group, o2 );

  if( !o.left )
  o.result.reverse( o.result );

  return o.result.original;

  /* */

  function handleNode( node, it )
  {

    if( o.onNode )
    o.onNode.apply( this, arguments );

    if( it.included )
    o.result.append( node );

  }

  function handleUp( node, it )
  {
    it.included = true;

    if( o.recursive === 0 )
    {
      it.continueUp = 0;
    }
    else if( o.recursive === 1 )
    {
      if( it.level > 0 )
      it.continueUp = 0;
    }

    if( it.included )
    if( !o.withStem && it.level === 0 )
    it.included = false;

    if( it.included )
    if( !o.withBranches || !o.withTerminals )
    {
      let degree = group.nodeOutdegree( node );
      if( !o.withBranches && degree > 0 )
      it.included = false;
      if( !o.withTerminals && degree === 0 )
      it.included = false;
    }

    if( o.onUp )
    o.onUp.apply( this, arguments );
  }

  function handleDown( node, it )
  {
    if( o.onDown )
    o.onDown.apply( this, arguments );
  }

  function handleBegin( it )
  {
    if( o.onBegin )
    o.onBegin.apply( this, arguments );
  }

  function handleEnd( it )
  {

    if( o.mandatory )
    if( !o.result.length )
    throw _.err( 'Found none node, but {- o.mandatory : 1 -}' );

    if( o.onEnd )
    o.onEnd.apply( this, arguments );

  }

}

var defaults = each_body.defaults = Object.create( lookDfs.defaults )

defaults.result = null;
defaults.method = null;

defaults.mandatory = 0;
defaults.recursive = 2;
defaults.withStem = 1;
defaults.withTerminals = 1;
defaults.withBranches = 1;

let each = _.routineFromPreAndBody( each_pre, each_body );

let eachBfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachBfs.defaults;
defaults.method = lookBfs;

let eachDfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachDfs.defaults;
defaults.method = lookDfs;

let eachCfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachCfs.defaults;
defaults.method = lookCfs;

//

/**
 * @summary Algorithm of linear ordering of directed acycled graph. Based on breadth-first search.
 * @description
 * Performs ordering using nodes with zero indegree.
 * Uses nodes of current group if `nodes` argument is not provided.
 * @param {Array} [nodes] Array of nodes.
 *
 * @example
 *
 * // define a graph of arbitrary structure
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c );
 * c.nodes.push( d );
 *
 * // declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // topological sort based on depth first search
 *
 * var ordering = group.topSortLeastDegreeBfs();
 * ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
 * console.log( ordering );
 *
 * //
 * //[
 * //  [ 'a' ],
 * //   [ 'b', 'c' ],
 * //  [ 'd' ]
 * //]
 *
 * @function topSortLeastDegreeBfs
 * @return {Array} Returns array with sorted layers.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function topSortLeastDegreeBfs( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let sources = group.leastIndegreeOnlyAmong( nodes );
  let result = group.lookBfs({ roots : sources });

  return _.arrayFlatten( null, result );
}

var routine = topSortLeastDegreeBfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function topSortCycledSourceBasedFastBfs( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !nodes.length )
  return sys.ContainerMake();

  /* */

  let collection = group.nodesStronglyConnectedCollection( nodes );
  let sources1 = collection.nodes.filter( ( node ) => collection.group.nodeIndegree( node ) === 0 ? node : undefined );
  let sources2 = sources1.flatFilter( ( node ) => node.originalNodes );
  collection.finit();

  debugger;
  let layers = group.lookBfs({ roots : sources2 });
  debugger;

  return _.arrayFlatten( null, layers );
}

var routine = topSortCycledSourceBasedFastBfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function topSortCycledSourceBasedPreciseBfs( nodes )
{
  let group = this;
  let sys = group.sys;

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !nodes.length )
  return sys.ContainerMake();

  /* */

  let collection = group.nodesStronglyConnectedCollection( nodes );
  let sources = collection.nodes.filter( ( node ) => collection.group.nodeIndegree( node ) === 0 ? node : undefined );
  let layers1 = sys.ContainerAdapterFrom( collection.group.lookBfs({ roots : sources }) );
  let layers2 = layers1.map( ( layer ) =>
  {
    return sys.ContainerAdapterFrom( layer ).flatFilter( ( node ) => node.originalNodes );
  });
  collection.finit();

  /* */

  let result = [];
  layers2.each( ( layer ) =>
  {
    let prev;
    let added = sys.ContainerAdapterFrom( new Set() );
    let nodeToInNodes = new HashMap();
    let nodeToOutNodes = new HashMap();
    layer.each( ( node ) => nodeToInNodes.set( node, group.nodeInNodesFor( node ).only( null, layer ).but( _.self, result ) ) );
    layer.each( ( node ) => nodeToOutNodes.set( node, group.nodeOutNodesFor( node ).only( null, layer ).but( _.self, result ) ) );
    if( !layer.any( ( node ) => addFastMaybe( node ) ) )
    {
      debugger;
      layer.most( ( node ) => nodeToOutNodes.get( node ).length ).first( ( node ) => add( node ) );
    }

    while( layer.length )
    {
      if( !nodeToOutNodes.get( prev ).first( ( node2 ) => addFastMaybe( node2 ) ) )
      {
        _.assert( added.length > 0 );
        added.empty();
        layer.most( ( node ) => nodeToOutNodes.get( node ).length ).first( ( node ) => add( node ) );
      }
    }

    function addFastMaybe( node )
    {
      let inNodes = nodeToInNodes.get( node );
      if( !inNodes.length )
      return add( node );
      else
      return false;
    }

    function add( node )
    {
      _.assert( !!node );
      nodeToOutNodes.get( node ).each( ( node2 ) => nodeToInNodes.get( node2 ).removeOnce( node ) );
      nodeToInNodes.get( node ).each( ( node2 ) => nodeToOutNodes.get( node2 ).removeOnce( node ) );
      added.append( node );
      result.push( node );
      layer.removedOnce( node );
      prev = node;
      return true;
    }

  });

  return result;
}

var routine = topSortCycledSourceBasedPreciseBfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

// --
// connectivity
// --

/**
 * @summary Returns path from the second node to the first.
 * @description Performs check using DFS algorithm.
 * @returns {Array of Node} Returns array of nodes.
 * @param {Pair of Node} pair Pair o nodes.
 * @function pairDirectedPathGetDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairDirectedPathGetDfs( pair )
{
  let group = this;
  let sys = group.sys;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = sys.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];
  let found = false;
  let result = [];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  // console.log( '-' );

  group.lookDfs
  ({
    roots : node2,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
    onDown : onDown1,
  });

  if( found )
  return result;
  return false;

  /* */

  function onUp1( node, it )
  {

    if( found )
    {
      it.continueNode = false;
      return;
    }

    if( node === node1 )
    {
      it.continueUp = false;
      found = true;
    }

  }

  /* */

  function onDown1( node, it )
  {

    if( found && it.continueNode )
    {
      result.unshift( node );
    }

  }

}

//

/**
 * @summary Returns true if path from the second node to the first exists.
 * @description Performs check using DFS algorithm.
 * @returns {boolean} Returns true if exists.
 * @param {Pair of Node} pair Pair o nodes.
 * @function pairDirectedPathExistsDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairDirectedPathExistsDfs( pair )
{
  let group = this;
  let sys = group.sys;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = sys.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];
  let found = false;

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  group.lookDfs
  ({
    roots : node2,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
  });

  return found;

  /* */

  function onUp1( node, it )
  {

    if( found )
    {
      it.continueNode = false;
      return;
    }

    if( node === node1 )
    {
      it.continueUp = false;
      found = true;
    }

  }

}

//

/**
 * @summary Returns true if two nodes are connected.
 * @description Performs check using DFS algorithm.
 * @param {Object} node1 First node.
 * @param {Object} node2 Second node.
 * @function pairIsConnectedDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairIsConnectedDfs( pair )
{
  let group = this;
  let sys = group.sys;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = sys.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  let r = group.lookDfs
  ({
    roots : node1,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
    onBegin,
  });

  if( r )
  return true;

  return group.lookDfs
  ({
    roots : node2,
    revisiting : 0,
    visitedContainer : new Set(),
    onUp : onUp2,
    onBegin,
  });

  /* */

  function onBegin( iterator )
  {
    iterator.result = false;
  }

  /* */

  function onUp1( node, it )
  {

    if( node === node2 )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

  /* */

  function onUp2( node, it )
  {

    if( node === node1 || visitedAdapter.has( node ) )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

}

//

/**
 * @summary Returns true if two nodes are connected strongly.
 * @description Performs check using DFS algorithm.
 * @param {Object} node1 First node.
 * @param {Object} node2 Second node.
 * @function pairIsConnectedStronglyDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairIsConnectedStronglyDfs( pair )
{
  let group = this;
  let sys = group.sys;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = sys.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  let r = group.lookDfs
  ({
    roots : node1,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
    onBegin,
  });

  if( !r )
  return false;

  return group.lookDfs
  ({
    roots : node2,
    revisiting : 0,
    visitedContainer : new Set(),
    onUp : onUp2,
    onBegin,
  });

  /* */

  function onBegin( iterator )
  {
    iterator.result = false;
  }

  /* */

  function onUp1( node, it )
  {

    if( node === node2 )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

  /* */

  function onUp2( node, it )
  {

    // if( node === node1 || _.arrayHas( visited, node ) )
    if( node === node1 || visitedAdapter.has( node ) )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

}

//

/**
 * @summary Group connected nodes.
 * @description Performs look using DFS algorithm.
 * @param {Array} nodes Array of nodes.]
 *
 * @example
 *
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c );
 * c.nodes.push( d );
 *
 * // declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // checking if nodes are connected using DFS algorithm
 *
 * var connected = group.pairIsConnectedDfs( a, d );
 * console.log( 'Nodes a and d are connected:', connected )
 *
 * var connected = group.pairIsConnectedDfs( b, d );
 * console.log( 'Nodes b and d are connected:', connected )
 *
 * // group connected nodes
 *
 * c.nodes = []; // break connection between c and d nodes
 * d.nodes.push( c ); // connect d and c nodes to make second group
 * var connectedNodes = group.nodesConnectedLayers();
 * console.log( 'Nodes grouped by connectivity:', connectedNodes )
 *
 * //[
 * //   a  b  c      d  c
 * //  [ 1, 2, 3 ], [ 4, 3 ]
 * //]
 *
 * @function nodesConnectedLayersDfs
 * @returns {Array} Returns array of arrays. Each inner array contains ids of connected nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesConnectedLayersDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let groups = [];
  let visitedContainer = sys.ContainerAdapterFrom( new Set );

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node ) =>
  {
    if( visitedContainer.has( node ) )
    return;
    groups.push( [] );
    group.lookDfs
    ({
      roots : node,
      onUp : handleUp,
      visitedContainer : visitedContainer,
    });
  });

  return groups;

  /* */

  function handleUp( node, it )
  {
    debugger;
    // visitedContainer.push( node );
    groups[ groups.length-1 ].push( node );
  }

}

var routine = nodesConnectedLayersDfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function nodesStronglyConnectedLayersDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let visited1 = sys.ContainerAdapterFrom( [] );
  let visited2 = sys.ContainerAdapterMake();
  let layers = [];

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.each( ( node ) =>
  {
    if( visited1.has( node ) )
    return;
    /*
      both visited1 and visitedContainer made with revisiting : 0 are required
      visitedContainer ( filled by DFS ) tracks visited nodes on up
      visited1 tracks visited nodes on down
      third container visited2 filled by DFS
    */
    group.lookDfs
    ({
      roots : [ node ],
      onUp :
      handleUp1,
      onDown : handleDown1,
      revisiting : 0,
    });
  });

  /* collect layers */

  group.reverse();

  visited1.eachRight( ( node, i ) =>
  {
    if( visited2.has( node ) )
    return;
    let layer = [];
    layers.push( layer );
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( layer ),
      visitedContainer : visited2,
      revisiting : 0,
    });
  });

  /* */

  return layers;

  /* */

  function handleUp1( node, it )
  {
    if( visited1.has( node ) )
    {
      it.continueUp = false;
      return;
    }
  }

  /* */

  function handleDown1( node, it )
  {
    if( !it.continueUp )
    return;
    visited1.push( node );
  }

  /* */

  function handleUp2_functor( layer )
  {
    return function handleUp2( node, it )
    {
      _.assert( visited1.has( node ), () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}` );
      layer.push( node );
    }
  }

}

var routine = nodesStronglyConnectedLayersDfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function nodesStronglyConnectedCollectionDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let visited1 = sys.ContainerAdapterFrom( [] );
  let visited2 = sys.ContainerAdapterFrom( new Set );
  let fromOriginal = new HashMap();

  // if( nodes === undefined )
  // nodes = group.nodes;
  // else
  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.each( ( node ) =>
  {
    if( visited1.has( node ) )
    return;
    /*
      both visited1 and visitedContainer made with revisiting : 0 are required
      visitedContainer ( filled by DFS ) tracks visited nodes on up
      visited1 tracks visited nodes on down
      third container visited2 filled by DFS
    */
    group.lookDfs
    ({
      roots : [ node ],
      onUp :
      handleUp1,
      onDown : handleDown1,
      revisiting : 0,
    });
  });

  /* make new graph */

  // let nodes2 = sys.ContainerAdapterFrom( new Set );
  let group2 = sys.nodesGroupDifferent
  ({
    onNodeNameGet : group.nodeNameFromGetterId,
    onOutNodesGet : group.nodesFromFieldOutNodes,
    onInNodesGet : group.nodesFromFieldInNodes,
  });
  let collection2 = sys.nodesCollection({ group : group2 });

  /* collect layers */

  group.reverse();

  visited1.eachRight( ( node, i ) =>
  {
    if( visited2.has( node ) )
    return;
    let dnode = dnodeMake();
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( dnode ),
      visitedContainer : visited2,
      revisiting : 0,
    });
  });

  /* add edges */

  collection2.nodes.each( ( dnode, l ) =>
  {
    dnode.originalOutNodes.each( ( node, t ) =>
    {
      if( dnode.originalNodes.has( node ) )
      return;
      let dnode2 = fromOriginal.get( node );
      dnode.outNodes.appendOnce( dnode2 );
      dnode2.inNodes.appendOnce( dnode );
    });
  });

  /* */

  return collection2;

  /* */

  function dnodeMake()
  {
    let dnode = Object.create( null );
    dnode.inNodes = sys.ContainerAdapterFrom( new Set );
    dnode.outNodes = sys.ContainerAdapterFrom( new Set );
    dnode.originalNodes = sys.ContainerAdapterFrom( new Set );
    dnode.originalOutNodes = sys.ContainerAdapterFrom( new Set );
    collection2.nodeAdd( dnode );
    return dnode;
  }

  /* */

  function handleUp1( node, it )
  {
    if( visited1.has( node ) )
    {
      it.continueUp = false;
      return;
    }
  }

  /* */

  function handleDown1( node, it )
  {
    if( !it.continueUp )
    return;
    visited1.push( node );
    _.assert( nodes.has( node ), () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}` );
  }

  /* */

  function handleUp2_functor( dnode )
  {
    return function handleUp2( node, it )
    {
      _.assert( visited1.has( node ), () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}` );
      fromOriginal.set( it.node, dnode );
      dnode.originalNodes.push( node );
      dnode.originalOutNodes.appendContainer( group.nodeOutNodesFor( node ) );
    }
  }

}

var routine = nodesStronglyConnectedCollectionDfs;
var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

// --
// etc
// --

function nodeNameFromGetterId( node )
{
  let group = this;
  return group.nodeToId( node );
}

//

function nodeNameFromFieldName( node )
{
  let group = this;
  return node.name;
}

//

function nodeIs_default( node )
{
  if( node === null || node === undefined )
  return false;
  return _.maybe;
}

//

function inNodesFromGroupCache( node )
{
  let group = this;
  let outNodes = group._inNodesCacheHash.get( node );
  // _.assert( _.setIs( outNodes ), 'No cache for the node' );
  _.assert( _.containerAdapter.is( outNodes ), `No cache for the ${group.nodeToQualifiedName( node )}` );
  return outNodes;
}

//

function nodesFromFieldNodes( node )
{
  let group = this;
  return node.nodes;
}

//

function nodesFromFieldOutNodes( node )
{
  let group = this;
  return node.outNodes;
}

//

function nodesFromFieldInNodes( node )
{
  let group = this;
  return node.inNodes;
}

//

function nodesFromIdsFromFieldNodes( node )
{
  let group = this;
  return group.idsToNodes( node.nodes );
}

//

function nodesFromIdsFromFieldOutNodes( node )
{
  let group = this;
  return group.idsToNodes( node.outNodes );
}

//

function nodesFromIdsFromFieldInNodes( node )
{
  let group = this;
  return group.idsToNodes( node.inNodes );
}

//

function nodesIdsFromNodesFromFieldNodes( node )
{
  let group = this;
  return group.nodesToIds( node.nodes );
}

//

function nodesIdsFromNodesFromFieldOutNodes( node )
{
  let group = this;
  return group.nodesToIds( node.outNodes );
}

//

function nodesIdsFromNodesFromFieldInNodes( node )
{
  let group = this;
  return group.nodesToIds( node.inNodes );
}

//

function nodesIdsFromFieldNodes( node )
{
  let group = this;
  return node.nodes;
}

//

function nodesIdsFromFieldOutNodes( node )
{
  let group = this;
  return node.outNodes;
}

//

function nodesIdsFromFieldInNodes( node )
{
  let group = this;
  return node.inNodes;
}

// --
// relations
// --

// let nodesSymbol = Symbol.for( 'nodes' );
let directSymbol = Symbol.for( 'direct' );

let Composes =
{
  direct : true,
  collections : _.define.own([]),
}

let Aggregates =
{
  onNodeNameGet : nodeNameFromGetterId,
  onNodeQualifiedNameGet : null,
  onNodeEvaluate : null, /* qqq : cover by tests */
  onNodeIs : nodeIs_default,
  onOutNodesGet : nodesFromFieldNodes,
  onInNodesGet : null,
  onNodeInfoExport : null,
  onNodeIdGet : null,
  onNodeFrom : null,
}

let Associates =
{
  sys : null,
  // nodes : _.define.own([]),
  context : null,
}

let Restricts =
{
  _inNodesCacheHash : null,
}

let Statics =
{

  // ContainerIs,
  // ContainerAdapterIs,
  // ContainerMake,
  // ContainerAdapterMake,
  // ContainerAdapterFrom,
  //
  // ContainerAdapter,
  // SetContainerAdapter,
  // ArrayContainerAdapter,

}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
  nodes : 'nodes',
}

let Accessors =
{
  // nodes : {},
  direct : {},
}

// --
// declare
// --

let Extend =
{

  init,
  finit,
  isUsed,
  form,
  unform,
  clone,

  // reverse

  directSet,
  reverse,
  cacheInNodesFromOutNodesInvalidate,
  cacheInNodesFromOutNodesOnce,
  cacheInNodesFromOutNodesUpdate,
  cacheInNodesFromOutNodesUpdateNode,
  cachesInvalidate,

  // export

  optionsExport,
  structureExport,
  infoExport,

  // descriptor

  nodeDescriptorWithNode,
  nodeDescriptorWith,
  nodeDescriptorObtain,
  nodeDescriptorDelete,

  // node

  // hasNode,
  // hasNodes : Vectorize( hasNode ),
  // hasAllNodes : VectorizeAll( hasNode ),
  // hasAnyNodes : VectorizeAny( hasNode ),
  // hasNoneNodes : VectorizeNone( hasNode ),

  nodeIs,
  nodesAre : Vectorize( nodeIs ),
  nodesAreAll : VectorizeAll( nodeIs ),
  nodesAreAny : VectorizeAny( nodeIs ),
  nodesAreNone : VectorizeNone( nodeIs ),

  nodeIndegree,
  nodesIndegree : Vectorize( nodeIndegree ),
  nodeOutdegree,
  nodesOutdegree : Vectorize( nodeOutdegree ),
  nodeDegree,
  nodesDegree : Vectorize( nodeDegree ),
  nodeOutNodesFor,
  nodesOutNodesFor : Vectorize( nodeOutNodesFor ),
  nodeInNodesFor,
  nodesInNodesFor : Vectorize( nodeInNodesFor ),
  nodeOutNodesIdsFor,
  nodesOutNodesIdsFor : Vectorize( nodeOutNodesIdsFor ),
  nodeInNodesIdsFor,
  nodesInNodesIdsFor : Vectorize( nodeInNodesIdsFor ),
  // nodeRefNumber,
  // nodesSet,

  // _nodeAdd,
  // nodeAdd,
  // nodesAdd : Vectorize( nodeAdd ),
  // _nodeAddOnce,
  // nodeAddOnce,
  // nodesAddOnce : Vectorize( nodeAddOnce ),
  // nodeDelete,
  // nodesDelete,

  nodeDataExport,
  nodesDataExport : Vectorize( nodeDataExport ),
  nodeInfoExport,
  nodesInfoExport,
  rootsExportInfoTree,

  nodeToQualifiedName,
  nodesToQualifiedNames : Vectorize( nodeToQualifiedName ),
  nodeToQualifiedNameTry,
  nodesToQualifiedNamesTry : Vectorize( nodeToQualifiedNameTry ),
  nodeToName,
  nodesToNames : Vectorize( nodeToName ),
  nodeToNameTry,
  nodesToNamesTry : Vectorize( nodeToNameTry ),

  // nodeToIdTry,
  // nodesToIdsTry : Vectorize( nodeToIdTry ),
  // nodeToId,
  // nodesToIds : Vectorize( nodeToId ),
  // idToNodeTry,
  // idsToNodesTry : Vectorize( idToNodeTry ),
  // idToNode,
  // idsToNodes : Vectorize( idToNode ),
  // idToName,
  // idsToNames : Vectorize( idToName ),

  // filter

  leastIndegreeAmong,
  mostIndegreeAmong,
  leastOutdegreeAmong,
  mostOutdegreeAmong,

  leastIndegreeOnlyAmong,
  mostIndegreeOnlyAmong,
  leastOutdegreeOnlyAmong,
  mostOutdegreeOnlyAmong,

  sourcesOnlyAmong,
  sinksOnlyAmong,

  // helper

  sourcesFromNodes,
  sourcesFromRoots,

  rootsToAllReachable,
  rootsToAll,
  asNodes,
  asNodesPreferSet,
  asNodesPreferArray,
  asNodesAdapter,

  nodeFrom,
  nodesFrom,

  _routineArguments1,
  _routineArguments2,

  // traverser

  lookBfs,
  lookDfs,
  lookCfs,
  look : lookDfs,

  each,
  eachBfs,
  eachDfs,
  eachCfs,

  // orderer

  dagTopSortDfs,
  dagTopSort : dagTopSortDfs,
  topSortLeastDegreeBfs,
  topSortCycledSourceBasedFastBfs,
  topSortCycledSourceBasedPreciseBfs,
  topSort : topSortCycledSourceBasedPreciseBfs,

  // connectivity

  pairDirectedPathGetDfs,
  pairDirectedPathGet : pairDirectedPathGetDfs,
  pairDirectedPathExistsDfs,
  pairDirectedPathExists : pairDirectedPathExistsDfs,
  pairIsConnectedDfs,
  pairIsConnected : pairIsConnectedDfs,
  pairIsConnectedStronglyDfs,
  pairIsConnectedStrongly : pairIsConnectedStronglyDfs,

  nodesConnectedLayersDfs,
  nodesConnectedLayers : nodesConnectedLayersDfs,
  nodesStronglyConnectedLayersDfs,
  nodesStronglyConnectedLayers : nodesStronglyConnectedLayersDfs,
  nodesStronglyConnectedCollectionDfs,
  nodesStronglyConnectedCollection : nodesStronglyConnectedCollectionDfs,

  // default

  nodeNameFromGetterId,
  nodeNameFromFieldName,
  nodeIs_default,
  inNodesFromGroupCache,

  nodesFromFieldNodes,
  nodesFromFieldOutNodes,
  nodesFromFieldInNodes,
  nodesFromIdsFromFieldNodes,
  nodesFromIdsFromFieldOutNodes,
  nodesFromIdsFromFieldInNodes,

  nodesIdsFromNodesFromFieldNodes,
  nodesIdsFromNodesFromFieldOutNodes,
  nodesIdsFromNodesFromFieldInNodes,
  nodesIdsFromFieldNodes,
  nodesIdsFromFieldOutNodes,
  nodesIdsFromFieldInNodes,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

})();
