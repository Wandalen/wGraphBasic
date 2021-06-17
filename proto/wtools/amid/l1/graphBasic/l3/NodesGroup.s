( function _NodesGroup_s_( ) {

'use strict';

/**
 * @classdesc Class to operate graph as group of nodes.
 * @class wAbstractNodesGroup
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphsgraph
 */

const _ = _global_.wTools;
const Parent = null;
let ContainerAdapter = _.containerAdapter.Abstract;
let ContainerAdapterSet = _.containerAdapter.Set;
let ContainerAdapterArray = _.containerAdapter.Array;
let _Vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let _VectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let _VectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let _VectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
const Self = wAbstractNodesGroup;
function wAbstractNodesGroup( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractNodesGroup';
Self.shortName2 = 'Group';

/*

visiting rules

|     | s:0 v:0 | s:0 v:1 | s:0 v:2 | s:1 v:0 | s:1 v:1 | s:1 v:2 | s:2 v:0 | s:2 v:1 | s:2 v:2 |
| --- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
| r:0 |         |         |         |         |         |         |         |         |         |
| r:1 |         |         |         |         |         |         |         |         |         |
| r:2 |         |         |         |         |         |         |         |         |         |
| r:3 |         |         |         |         |         |         |         |         |         |
| --- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |

*/

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

    // if( r.name === 'nodeIs' )
    // debugger;

    let result = originalVectorize( r );
    _.assert( _.routineIs( result ) );
    if( r.properties && r.input === 'Node' )
    {
      routineAdjust( result );
      // result.input = '(*Node)';
      // result.properties = result.properties || Object.create( null );
      // if( result.properties.forCollection === undefined )
      // result.properties.forCollection = true;
    }
    if( r.properties && r.input === 'Junction' )
    {
      routineAdjust( result );
      // result.input = '(*Junction)';
      // result.properties = result.properties || Object.create( null );
      // if( result.properties.forCollection === undefined )
      // result.properties.forCollection = true;
    }
    return result;
  }

  function routineAdjust( r )
  {
    _.assert( _.strIs( r.input ) );
    _.assert( _.object.isBasic( r.properties ) );
    r.input = `(*${r.input})`;
    r.properties = r.properties || Object.create( null );
    if( r.properties.forCollection === undefined )
    r.properties.forCollection = true;
    return r;
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

  _.workpiece.initFields( group );
  Object.preventExtensions( group );

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

  let collections = _.entity.cloneShallow( group.collections );
  _.container.empty( group.collections );

  _.assert( collections !== group.collections );
  _.assert( group.collections.length === 0 );

  collections.forEach( ( collection ) =>
  {
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
    val || _.routineIs( group.onNodeInNodes ),
    () => 'Expects defined callback {-onNodeInNodes-}. Define it or call method cacheInNodesFromOutNodesOnce before reversing graph.'
  );
  // if( !val && !group.onNodeInNodes )
  // group.cacheInNodesFromOutNodesOnce();

  let onNodeOutNodes = group.onNodeOutNodes;
  let onNodeInNodes = group.onNodeInNodes;

  _.assert( _.routineIs( onNodeOutNodes ), 'Direct neighbour nodes getter is not defined' );
  _.assert( _.routineIs( onNodeInNodes ), 'Reverse neighbour nodes getter is not defined' );

  group.onNodeOutNodes = onNodeInNodes;
  group.onNodeInNodes = onNodeOutNodes;

  group[ directSymbol ] = val;
  return group;
}

// --
// cache
// --

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

  if( !group.onNodeInNodes )
  group.onNodeInNodes = group._inNodesFromGroupCache;

  if( !group._inNodesCacheHash )
  group._inNodesCacheHash = new HashMap();

  nodes.each( ( node ) =>
  {
    let junction = group.nodeJunction( node );
    group._inNodesCacheHash.set( junction, sys.ContainerAdapterFrom( new Set ) );
  });

  nodes.each( ( node ) =>
  {
    group.cacheInNodesFromOutNodesUpdateNode( node );
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
  let junction = group.nodeJunction( node );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( !!group.onNodeInNodes );
  _.assert( !!group._inNodesCacheHash );

  if( !group._inNodesCacheHash.has( junction ) )
  group._inNodesCacheHash.set( junction, sys.ContainerAdapterFrom( new Set ) );

  let directNeighbours = group.nodeOutNodesFor( node );
  directNeighbours = sys.ContainerAdapterFrom( directNeighbours );
  directNeighbours.each( ( node2 ) =>
  {
    let junction2 = group.nodeJunction( node2 );
    let inNodes = group._inNodesCacheHash.get( junction2 );
    if( !inNodes )
    {
      inNodes = sys.ContainerAdapterFrom( new Set );
      group._inNodesCacheHash.set( junction2, inNodes );
    }
    _.assert( !!inNodes, `Cant retrive in nodes of ${group.nodeToQualifiedName( node2 )} from cache` );
    inNodes.push( node );
  });

  return group._inNodesCacheHash;
}

//

function cacheInNodesExportInfo()
{
  let group = this;
  let sys = group.sys;
  let result = '';

  if( group._inNodesCacheHash )
  group._inNodesCacheHash.forEach( ( inNodes, junction ) =>
  {
    result += group.junctionToName( junction ) + ' : ' + group.nodesToNames( inNodes ).join( '+' ) + '\n';
  });

  return result;
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

  result.onNodeIs = group.onNodeIs;
  result.onNodeName = group.onNodeName;
  result.onNodeQualifiedName = group.onNodeQualifiedName;
  result.onNodeOutNodes = group.onNodeOutNodes;
  result.onNodeInNodes = group.onNodeInNodes;
  result.onNodeInfoExport = group.onNodeInfoExport;
  result.onNodeFrom = group.onNodeFrom;
  result.onNodeJunction = group.onNodeJunction;

  result.onJunctionIs = group.onJunctionIs;
  result.onJunctionName = group.onJunctionName;
  result.onJunctionNodes = group.onJunctionNodes;

  return result
}

//

function exportStructure( o )
{
  let group = this;
  let sys = group.sys;

  o = _.routine.options_( exportStructure, arguments );

  o.nodes = group.asNodesAdapter( o.nodes );

  let result = Object.create( null );
  result.nodes = group.nodesDataExport( o.nodes );

  return result;
}

exportStructure.defaults =
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
 * @function exportString
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function exportString( o )
{
  let group = this;
  let sys = group.sys;

  o = _.routine.options_( exportString, arguments );

  o.nodes = group.asNodesAdapter( o.nodes );

  let result = group.nodesInfoExport( o.nodes, o );

  return result;
}

var routine = exportString;

routine.defaults =
{
  verbosity : 2,
  nodes : null,
  it : null,
}

routine.properties = /* xxx : ? */
{
  forCollection : 1,
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`.
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorWithNode
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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

/**
 * @summary Returns true if provided entity `node` is a node.
 * @param {Object} node Node descriptor.
 * @function nodeIs
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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

/**
 * @summary Returns name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToName
 * @returns {String} Returns name of node.
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function nodeToName( node )
{
  let group = this;
  let sys = group.sys;
  let result;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( arguments.length === 1 );

  result = group.onNodeName( node );

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

/**
 * @summary Returns qualified name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToQualifiedName
 * @returns {String} Returns name of node.
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function nodeToQualifiedName( node )
{
  let group = this;
  let sys = group.sys;
  let result;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( arguments.length === 1 );

  if( group.onNodeQualifiedName === null )
  {
    result = 'node::' + group.nodeToName( node );
  }
  else
  {
    result = group.onNodeQualifiedName( node );
  }

  _.assert( _.primitiveIs( result ) && result !== undefined, 'Cant get qualified name for the node' );

  return String( result );
}

//

/**
 * @summary Try to return qualified name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToQualifiedNameTry
 * @returns {String} Returns name of node.
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
  let result = sys.ContainerAdapterFrom( group.onNodeOutNodes( node ) );
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
  let result = sys.ContainerAdapterFrom( group.onNodeInNodes( node ) );
  _.assert( sys.ContainerIs( result ), () => `Cant retrive out nodes of ${group.nodeToQualifiedNameTry( node )}` );
  return result;
}

var routine = nodeInNodesFor;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

//

function nodeJunction( node )
{
  let group = this;
  let sys = group.sys;
  _.assert( !!group.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  if( group.onNodeJunction )
  {
    _.assert( _.routineIs( group.onNodeJunction ), 'Group does not have defined callback {- onNodeJunction -}' );
    let result = group.onNodeJunction( node );
    _.assert( result !== undefined, `No junction for a node` );
    return result;
  }
  else
  {
    return node;
  }
}

var routine = nodeJunction;
var properties = routine.properties = Object.create( null );
routine.input = 'Node';

// --
// node exporter
// --

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
  {
    let node2 = node;
    return group.onNodeInfoExport( node2, o );
  }

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
  if( arguments.length === 1 )
  opts = Object.create( null );
  let sys = group.sys;
  let result = '';
  let prevIt;
  let lastNodes;
  let tab;

  roots = group._routineArguments1( roots );
  opts = _.routine.options_( rootsExportInfoTree, opts );

  if( opts.onNodeName === null )
  opts.onNodeName = group.onNodeName || defaultOnNodeName;

  _.assert( opts.dtab1.length === opts.dtab2.length );
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );

  lastNodes = new HashMap;
  tab = '';

  prevIt = { level : Infinity };
  group.lookDfs
  ({
    roots : roots,
    onBegin : handleBegin,
    onUp : handleUp1,
    onDown : handleDown1,
    fast : 0,
    revisiting : opts.revisiting,
    allSiblings : opts.allSiblings,
    allVariants : opts.allVariants,
  });

  if( prevIt.down )
  lastNodeAdd( prevIt.node, prevIt.down.node, prevIt.index );

  /*
    for debugging. do not delete
  */

    // logger.log( '' );
    // logger.log( 'Last nodes' );
    // for( let [ node, parents ] of lastNodes )
    // {
    //   for( let parent of parents )
    //   logger.log( ( parent ? group.nodeToName( parent ) : String( parent ) ) + ' -> ' + group.nodeToName( node ) );
    // }
    // logger.log( '' );

  prevIt = { level : 0, node : null };
  group.lookDfs
  ({
    roots : roots,
    onBegin : handleBegin,
    onUp : handleUp2,
    onDown : handleDown2,
    fast : 0,
    revisiting : opts.revisiting,
    allSiblings : opts.allSiblings,
    allVariants : opts.allVariants,
  });

  return result;

  /* */

  function lastNodeAdd( node, downNode, index )
  {
    _.assert( _.intIs( index ) );
    lastNodes.set( node, lastNodes.get( node ) || [] );
    let descriptors = lastNodes.get( node );
    descriptors.push({ downNode, index });
  }

  /* */

  function lastNodeIs( node, downNode, index )
  {
    _.assert( _.intIs( index ) );
    let descriptors = lastNodes.get( node );
    if( !descriptors )
    return false;
    return !!_.any( descriptors, ( descriptor ) => descriptor.downNode === downNode && descriptor.index === index );
    // lastNodes.has( prevIt.node ) && lastNodes.get( prevIt.node ).has( prevIt.down.node )
  }

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

    if( !it.iterator.continue || !it.continueNode )
    {
      debugger;
      return;
    }

    let dLevel = it.level - prevIt.level;
    if( dLevel < 0 && prevIt.node !== undefined )
    {
      lastNodeAdd( prevIt.node, prevIt.down.node, prevIt.index );
    }
    prevIt = it;
  }

  /* */

  function handleUp2( node, it )
  {

    if( opts.onUp )
    opts.onUp( node, it );

    if( !it.iterator.continue || !it.continueNode )
    {
      debugger;
      return;
    }

    let isLast = ( prevIt && prevIt.down ) ? lastNodeIs( prevIt.node, prevIt.down.node, prevIt.index ) : false;
    let dLevel = it.level - prevIt.level;
    let name = opts.onNodeName( node );

    if( dLevel < 0 )
    tab = tab.substring( 0, tab.length + dLevel*opts.dtab1.length );

    if( dLevel > 0 )
    tab += isLast ? opts.dtab2 : opts.dtab1;

    if( opts.rootsDelimiting )
    if( it.level === 0 && it.index > 0 )
    {
      result += opts.linePrefix + opts.dtab1 + opts.linePostfix;
    }

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

  /* */

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
  revisiting : 2,
  allSiblings : 2,
  allVariants : 2,
  onNodeName : null,
  onUp : null,
  onDown : null,
}

// --
// junction
// --

/**
 * @summary Returns true if provided entity is a junction.
 * @param {*} junction Junction descriptor.
 * @function junctionIs
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function junctionIs( junction )
{
  let group = this;
  let sys = group.sys;
  return group.onJunctionIs( junction );
}

var routine = junctionIs;
var properties = routine.properties = Object.create( null );
routine.input = 'Junction';

//

/**
 * @summary Returns name of junction. Takes single argument - a junction.
 * @param {Object} junction Node descriptor.
 * @function junctionToName
 * @returns {String} Returns name of junction.
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function junctionToName( junction )
{
  let group = this;
  let sys = group.sys;
  let result;

  _.assert( !!group.junctionIs( junction ), 'Expects junction' );
  _.assert( arguments.length === 1 );

  if( group.onNodeJunction )
  result = group.onJunctionName( junction );
  else
  result = group.onNodeName( junction );

  _.assert( _.primitiveIs( result ) && result !== undefined, 'Cant get name for the junction' );

  return String( result );
}

var routine = junctionToName;
var properties = routine.properties = Object.create( null );
routine.input = 'Junction';

//

function junctionNodes( junction )
{
  let group = this;
  let sys = group.sys;
  _.assert( !!group.junctionIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( group.onJunctionNodes ), 'Group does not have defined callback {- onJunctionNodes -}' );
  let result = group.onJunctionNodes( node );
  _.assert( result !== undefined, `No junction for a node` );
  return result;
}

var routine = junctionNodes;
var properties = routine.properties = Object.create( null );
routine.input = 'Junction';

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

  if( !group.onNodeInNodes )
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

  if( !group.onNodeInNodes )
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

  // if( !group.onNodeInNodes )
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

  // if( !group.onNodeInNodes )
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

  if( !group.onNodeInNodes )
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function sourcesFromNodes( dstNodes, srcNodes )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcNodes ] = group._routineArguments2( ... arguments );

  if( dstNodes.original === srcNodes.original )
  {
    if( !group.onNodeInNodes && dstNodes.length )
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
    if( !group.onNodeInNodes || group._inNodesCacheHash )
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function rootsToAllReachable( dstNodes, srcRoots )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcRoots ] = group._routineArguments2( ... arguments );

  // let o2 = { roots : srcRoots, onUp : onUp, allVariants : 2 }
  let o2 = { roots : srcRoots, onUp : onUp, onNodeJunction : 0 }
  // let o2 = { roots : srcRoots, onUp : onUp }
  group.lookDfs( o2 );

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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function rootsToAll( dstNodes, srcRoots )
{
  let group = this;
  let sys = group.sys;

  [ dstNodes, srcRoots ] = group._routineArguments2( ... arguments );

  if( srcRoots === dstNodes )
  srcRoots = srcRoots.make();

  // group.lookDfs({ roots : srcRoots, onUp : onUp, allVariants : 2 });
  group.lookDfs({ roots : srcRoots, onUp : onUp, onNodeJunction : 0 });
  // group.lookDfs({ roots : srcRoots, onUp : onUp });
  if( !group.direct || group.onNodeInNodes )
  {

    if( !group.onNodeInNodes || group._inNodesCacheHash )
    group.cacheInNodesFromOutNodesUpdate( srcRoots );

    group.reverse();
    // group.lookDfs({ roots : srcRoots, onUp : onUp, allVariants : 2 });
    group.lookDfs({ roots : srcRoots, onUp : onUp, onNodeJunction : 0 });
    // group.lookDfs({ roots : srcRoots, onUp : onUp });
    group.reverse();

    if( !group.onNodeInNodes || group._inNodesCacheHash )
    group.cacheInNodesFromOutNodesUpdate( dstNodes );

  }

  return dstNodes.original;

  function onUp( node )
  {
    dstNodes.appendOnce( node );
  }

}

//

/**
 * @summary Put node in a container if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function asNodes
 * @return {Array|Set} Returns array with sorted nodes.
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function asNodes( nodes )
{
  let group = this;
  let sys = group.sys;

  if( sys.ContainerIs( nodes ) )
  return nodes;

  let nodeIs = group.nodeIs( nodes );
  _.assert( nodeIs === true || nodeIs === _.maybe );
  // _.assert( group.nodeIs( nodes ) ); /* Dmytro : group.nodeIs() returns symbol _.maybe, double negation can make not valid result for other symbols */
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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

  let nodeIs = group.nodeIs( nodes );
  _.assert( nodeIs === true || nodeIs === _.maybe );
  // _.assert( group.nodeIs( nodes ) );
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
  _.assert( !!group.nodeIs( result ), () => `Cant get node from ${_.entity.exportStringDiagnosticShallow( result )}` );
  return result;
}

//

function nodesFrom( nodes )
{
  let group = this;
  let sys = group.sys;
  let result = _.container.map_( null, nodes, ( node ) => group.nodeFrom( node ) );
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
  dstNodes = _.entity.makeEmpty( srcNodes.original );
  dstNodes = sys.ContainerAdapterFrom( dstNodes );

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( sys.ContainerIs( dstNodes ) );
  _.assert( sys.ContainerIs( srcNodes ) );

  return [ dstNodes, srcNodes ]
}

// --
// traverser
// --

function _look_head( routine, args )
{
  let group = this;
  let sys = group.sys;

  let o = _.routine.options_( routine, args );

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = o.revisiting === 2 ? new Array() : new Set();
  if( o.visitedContainer )
  o.visitedContainer = sys.ContainerAdapterFrom( o.visitedContainer );

  if( o.allVariants === null )
  o.allVariants = 0;
  if( o.allSiblings === null )
  o.allSiblings = 0;
  _.assert( 0 <= o.allVariants && o.allVariants <= 2 );
  _.assert( 0 <= o.allSiblings && o.allSiblings <= 2 );

  let onNodeJunction = o.onNodeJunction === null ? group.onNodeJunction : o.onNodeJunction;
  let allDirect = o.left ? 'allLeft' : 'allRight';
  let allRevert = o.left ? 'allRight' : 'allLeft';

  o.roots = group.asNodesPreferSet( o.roots );
  o.roots = group.asNodesAdapter( o.roots );

  if( Config.debug )
  {
    _.assert( args.length === 1 );
    _.assert( group.nodesAreAll( o.roots ) );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( o.allVariants === null || ( 0 <= o.allVariants && o.allVariants <= 2 ) );
    _.assert( o.allSiblings === null || ( 0 <= o.allSiblings && o.allSiblings <= 2 ) );
    _.assert( o.roots.all( ( node ) => group.nodeIs( node ) ) );
    _.assert( !o.visitedContainer || o.revisiting !== 2 || _.arrayIs( o.visitedContainer.original ) )
  }

  return o;
}

let _lookDefaults =
{

  roots : null,
  visitedContainer : null,

  left : 1, /* qqq : cover option left */
  revisiting : 0, /* [ 0, 1, 2, 3 ] */
  allSiblings : null, /* [ 0, 1, 2 ] */
  allVariants : null, /* [ 0, 1, 2 ] */
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,
  onNodeJunction : null,

}

//

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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function lookBfs_body( o )
{
  let group = this;
  let sys = group.sys;

  if( o.allVariants === null )
  o.allVariants = o.revisiting === 0 ? 0 : 1;
  if( o.allSiblings === null )
  o.allSiblings = o.revisiting === 0 ? 0 : 1;
  _.assert( 0 <= o.allVariants && o.allVariants <= 2 );
  _.assert( 0 <= o.allSiblings && o.allSiblings <= 2 );

  _.routine.assertOptions( lookBfs_body, o );

  let onNodeJunction = o.onNodeJunction === null ? group.onNodeJunction : o.onNodeJunction;
  let allDirect = o.left ? 'allLeft' : 'allRight';
  let allRevert = o.left ? 'allRight' : 'allLeft';
  let containerIsSet = true;

  if( o.allSiblings === 0 )
  {
    if( !onNodeJunction || o.allVariants === 0 )
    {
      o.roots = o.roots.toSet();
      o.roots.once( o.roots, onNodeJunction );
    }
    else if( o.allVariants === 1 )
    {
      o.roots = o.roots.toSet();
    }
    else
    {
      o.roots = o.roots.toSet();
      // containerIsSet = false;
    }
  }
  else
  {
    o.roots = o.roots.toArray();
    containerIsSet = false;
  }

  let iterator = o;
  iterator.iterator = iterator;
  iterator.options = o;
  iterator.visitedContainer = o.visitedContainer;
  iterator.layers = [];
  iterator.level = 0;
  iterator.index = null;
  iterator.node = null;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.continueNode = true;
  iterator.visited = false;
  iterator.result = iterator.layers;

  if( o.onBegin )
  o.onBegin( iterator );

  nodesVisit( o.roots, iterator );

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function nodesVisit( nodes, it )
  {
    let nodes2 = sys.ContainerAdapterFrom( containerIsSet ? new Set : new Array );
    let nodesStatus = new HashMap;
    let siblingsContainer;

    it.layers.push( nodes.original );
    /* qqq : optimize. add proper condition */
    // if( ( o.revisiting >= 1 && o.allVariants === 0 ) || ( o.revisiting === 0 && o.allVariants === 1 ) )
    siblingsContainer = sys.ContainerAdapterFrom( new Set )

    if( o.onLayerUp )
    o.onLayerUp( nodes, it );

    delete it.node;
    let itIndex = it.index;
    let itVisited = it.visited;
    let itContinueUp = it.continueUp;
    let itContinueNode = it.continueNode;

    if( it.iterator.continue )
    nodes[ allDirect ]( ( node, k ) =>
    {

      it.node = node;
      it.index = k;
      it.visited = false;
      it.continueUp = true;
      it.continueNode = true;

      if( !nodeCanVisit1( it, siblingsContainer, nodesStatus ) )
      {
        // if( onNodeJunction )
        // {
        //   if( o.visitedContainer )
        //   o.visitedContainer.appendOnce( node );
        // }
        // if( !onNodeJunction || o.allVariants !== 2 || !nodesStatus.has( it.node ) )
        // {
        //   nodesStatus.set( it.node, [ false, false, true ] );
        // }
        // else
        // {
        // }
        return true;
      }

      nodeUp( it );
      nodeAdd( it, siblingsContainer, nodes2 );

      nodesStatus.set( k, [ it.continueUp, it.continueNode, it.visited ] );

      it.continueNode = itContinueNode;
      it.continueUp = itContinueUp;

      return it.iterator.continue;
    });

    delete it.node;
    it.index = itIndex;
    it.visited = itVisited;
    it.continueUp = itContinueUp;
    it.continueNode = itContinueNode;

    if( !it.continueNode )
    it.continueUp = false;

    if( o.visitedContainer )
    o.visitedContainer.appendContainerOnce( siblingsContainer );

    if( nodes2.length )
    tabLevelUp( nodes2, it );

    /* */

    /* zzz : use filterRight/filterLeft */
    nodes[ allRevert ]( ( node, k ) =>
    {
      it.node = node;
      it.index = k;
      _.assert( nodesStatus.has( k ) );
      [ it.continueUp, it.continueNode, it.visited ] = nodesStatus.get( k );
      nodeDown( it );
      return true;
    });
    nodes.filterRight( nodes, ( node, k ) =>
    {
      [ it.continueUp, it.continueNode, it.visited ] = nodesStatus.get( k );
      return it.continueNode ? node : undefined;
    });

    if( o.onLayerDown )
    o.onLayerDown( nodes, it );

    it.continueUp = true;
  }

  /* */

  function tabLevelUp( nodes2, it )
  {

    if( !it.iterator.continue || !it.continueUp )
    return;

    let level = it.level;
    let continueNode = it.continueNode;
    it.level += 1;
    nodesVisit( nodes2, it );
    it.level = level;
    it.continueNode = continueNode;

  }

  /* */

  function nodeCanVisit1( it, siblingsContainer, nodesStatus )
  {
    let _hasJunction;
    let _hasNode;

    if( o.revisiting === 2 )
    {
      it.visited = o.visitedContainer.count( it.node, onNodeJunction );

      if( it.visited >= 1 )
      {
        it.continueUp = false;
      }

    }
    else if( o.revisiting < 2 )
    {

      if( o.visitedContainer.has( it.node, onNodeJunction ) )
      {
        it.visited = true;
        if( siblingsContainer && siblingsHasJunction() )
        return end( true );
        return end( false );
      }

    }

    if( o.allSiblings === 0 && siblingsContainer )
    {
      if( siblingsHasNode() )
      return end( false );
    }

    if( o.allVariants === 0 && onNodeJunction && siblingsContainer )
    {
      if( siblingsHasJunction() )
      if( !siblingsHasNode() )
      return end( false );
    }

    return end( true );

    function end( result )
    {
      if( !result )
      {
        if( onNodeJunction )
        {
          if( o.visitedContainer )
          o.visitedContainer.appendOnce( it.node );
        }
        // if( !onNodeJunction || o.allVariants !== 2 || !nodesStatus.has( it.node ) )
        // {
          nodesStatus.set( it.index, [ false, false, true ] );
        // }
        // else
        // {
        //   it.continueUp = false;
        //   it.continueNode = false;
        // }
      }
      return result;
    }

    function siblingsHasNode()
    {
      if( _hasNode !== undefined )
      return _hasNode ;
      _hasNode = siblingsContainer.has( it.node );
      if( !onNodeJunction )
      _hasJunction = _hasNode;
      return _hasNode;
    }

    function siblingsHasJunction()
    {
      if( _hasJunction !== undefined )
      return _hasJunction ;
      _hasJunction = siblingsContainer.has( it.node, onNodeJunction );
      if( !onNodeJunction || !_hasJunction )
      _hasNode = _hasJunction;
      return _hasJunction;
    }

  }

  /* */

  function nodeAdd( it, siblingsContainer, nodes2 )
  {

    let isFirstNode = !siblingsContainer.has( it.node );
    let isFirstVariant = isFirstNode;
    if( isFirstVariant && onNodeJunction )
    isFirstVariant = !siblingsContainer.has( it.node, onNodeJunction );
    if( siblingsContainer && isFirstNode )
    siblingsContainer.append( it.node );

    if( it.continueUp )
    {
      let adding1 = 0;
      let adding2 = 0;

      if( o.allSiblings === 0 )
      {
        if( isFirstNode )
        adding1 = 1;
        else
        adding1 = 0;
      }
      else if( o.allSiblings === 1 )
      {
        if( isFirstNode )
        adding1 = 2;
        else
        adding1 = 0;
      }
      else if( o.allSiblings === 2 )
      {
        adding1 = 2;
      }

      if( o.allVariants === 0 )
      {
        if( isFirstVariant )
        adding2 = 1;
        else
        adding2 = 0;
      }
      else if( o.allVariants === 1 )
      {
        if( isFirstVariant )
        adding2 = 2;
        else
        adding2 = 0;
      }
      else if( o.allVariants === 2 )
      {
        adding2 = 2;
      }

      if( adding1 === 0 )
      {
      }
      else if( adding2 === 0 )
      {
        if( !isFirstNode )
        if( adding1 === 2 )
        nodes2.appendContainer( group.nodeOutNodesFor( it.node ) );
        else
        nodes2.appendContainerOnce( group.nodeOutNodesFor( it.node ) );
      }
      else if( adding2 === 1 )
      {
        if( adding1 === 1 )
        nodes2.appendContainerOnce( group.nodeOutNodesFor( it.node ), onNodeJunction );
        else
        group.nodeOutNodesFor( it.node ).each( ( node ) =>
        {
          let hasNode = nodes2.has( node );
          let hasJunction = hasNode;
          if( !hasJunction && onNodeJunction )
          hasJunction = nodes2.has( node, onNodeJunction );
          if( hasJunction && !hasNode )
          return;
          nodes2.append( node );
        });
      }
      else if( adding1 === 1 )
      {
        nodes2.appendContainerOnce( group.nodeOutNodesFor( it.node ) );
      }
      else
      {
        nodes2.appendContainer( group.nodeOutNodesFor( it.node ) );
      }

    }

  }

  /* */

  function nodeUp( it )
  {

    // logger.log( _.strDup( '  ', it.level ) + ' up ' + it.node.name );

    if( o.onUp )
    o.onUp( it.node, it );

    if( !it.continueNode )
    it.continueUp = false;

    if( it.continueNode )
    if( o.onNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    it.continueUp = false;

  }

  /* */

  function nodeDown( it )
  {

    if( !it.continueNode )
    return true;

    // logger.log( _.strDup( '  ', it.level ) + ' down ' + it.node.name );

    if( o.onDown )
    o.onDown( it.node, it );

  }

  /* */

}

lookBfs_body.defaults =
{

  ... _lookDefaults,

  onLayerUp : null,
  onLayerDown : null,

}

let lookBfs = _.routine.uniteCloning_replaceByUnite( _look_head, lookBfs_body );

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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function lookDfs_body( o )
{
  let group = this;
  let sys = group.sys;

  if( o.allVariants === null )
  o.allVariants = o.revisiting === 0 ? 0 : 2;
  if( o.allSiblings === null )
  o.allSiblings = o.revisiting === 0 ? 0 : 2;
  _.assert( 0 <= o.allVariants && o.allVariants <= 2 );
  _.assert( 0 <= o.allSiblings && o.allSiblings <= 2 );
  _.routine.assertOptions( lookDfs_body, o );

  if( o.onIteration === null )
  {
    if( o.fast )
    o.onIteration = iterationFast;
    else
    o.onIteration = iterationSlow;
  }

  let onNodeJunction = o.onNodeJunction === null ? group.onNodeJunction : o.onNodeJunction;
  let allDirect = o.left ? 'allLeft' : 'allRight';
  let allRevert = o.left ? 'allRight' : 'allLeft';
  let eachDirect = o.left ? 'eachLeft' : 'eachRight';

  let iterator = o;
  iterator.iterator = iterator;
  iterator.options = o;
  iterator.visitedContainer = o.visitedContainer;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.continueNode = true;
  iterator.result = null;
  iterator.level = -1;
  iterator.visited = false;

  if( o.onBegin )
  o.onBegin( iterator );

  nodesVisit( o.roots, iterator );

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function nodeVisit( it, siblingsContainer )
  {

    if( !nodeCanVisit2( it, siblingsContainer ) )
    return;

    if( o.visitedContainer )
    o.visitedContainer.push( it.node );

    nodeUp( it );

    if( !it.continueNode )
    {
      it.continueUp = false;
    }

    if( it.iterator.continue && it.continueUp )
    {
      let outNodes = group.nodeOutNodesFor( it.node );
      nodesVisit( outNodes, it );
    }

    nodeDown( it );

    if( siblingsContainer )
    siblingsContainer.append( it.node );

    if( !it.continueNode )
    {
      if( o.visitedContainer )
      if( o.revisiting !== 1 && o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );
    }

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      o.visitedContainer.pop( it.node );
    }

  }

  /* */

  function nodesVisit( outNodes, it )
  {
    let itLevel = it.level;
    let itNode = it.node;
    let itIndex = it.index;
    let itVisited = it.visited;
    let itContinueNode = it.continueNode;
    let itContinueUp = it.continueUp;
    let siblingsContainer;
    let continueContainer;

    if( onNodeJunction )
    if( ( o.revisiting >= 1 && o.allVariants === 0 ) || ( o.revisiting === 0 && o.allVariants >= 1 ) || ( o.revisiting >= 1 && o.allVariants === 1 ) )
    siblingsContainer = sys.ContainerAdapterFrom( new Set );
    if( !siblingsContainer )
    if( ( o.revisiting >= 1 && o.allSiblings === 0 ) || ( o.revisiting === 0 && o.allSiblings >= 1 ) || ( o.revisiting >= 1 && o.allSiblings === 1 ) )
    siblingsContainer = sys.ContainerAdapterFrom( new Set );

    if( o.revisiting === 0 )
    if( o.allVariants >= 1 || o.allSiblings >= 1 )
    continueContainer = new Array( outNodes.length );
    if( continueContainer )
    outNodes[ eachDirect ]( ( node, k ) =>
    {
      it.node = node;
      continueContainer[ k ] = nodeCanVisit1( it );
    });

    outNodes[ allDirect ]( ( node, k ) =>
    {

      if( continueContainer )
      if( !continueContainer[ k ] )
      return true;

      let it2 = o.onIteration( iterator, it );

      // let it2 = it;
      // if( o.fast )
      // {
      //   it2.visited = false;
      //   it2.continueNode = true;
      //   it2.continueUp = true;
      // }
      // else
      // {
      //   it2 = Object.create( iterator );
      //   it2.down = it;
      // }

      it2.node = node;
      it2.index = k;
      it2.level = itLevel + 1;

      nodeVisit( it2, siblingsContainer );

      return it2.iterator.continue;
    });

    it.level = itLevel;
    it.node = itNode;
    it.index = itIndex;
    it.visited = itVisited;
    it.continueNode = itContinueNode;
    it.continueUp = itContinueUp;
  }

  /* */

  function nodeCanVisit1( it )
  {

    if( o.revisiting < 2 )
    {
      if( o.visitedContainer.has( it.node, onNodeJunction ) )
      {
        if( onNodeJunction && o.revisiting === 0 )
        o.visitedContainer.appendOnce( it.node );
        return false;
      }
    }

    return true;
  }

  /* */

  function nodeCanVisit2( it, siblingsContainer )
  {
    let hasNode;
    if( siblingsContainer )
    hasNode = siblingsContainer.has( it.node );
    let hasJunction = hasNode;
    if( siblingsContainer && onNodeJunction && hasJunction === false )
    hasJunction = siblingsContainer.has( it.node, onNodeJunction );

    if( siblingsContainer && o.allSiblings === 0 )
    if( hasNode )
    {
      it.continueNode = false;
      return false;
    }

    if( it.continueUp )
    if( o.revisiting >= 1 && o.allSiblings === 1 && siblingsContainer )
    if( hasNode )
    {
      it.continueUp = false;
    }

    if( it.continueUp )
    if( siblingsContainer && onNodeJunction && o.allVariants === 0 )
    if( hasJunction )
    if( o.allSiblings === 0 || !hasNode )
    {
      it.continueNode = false;
      return false;
    }

    if( it.continueUp )
    if( o.revisiting >= 1 && o.allVariants === 1 && siblingsContainer && onNodeJunction )
    if( hasJunction )
    if( o.allSiblings === 0 || !hasNode )
    {
      it.continueUp = false;
    }

    if( o.revisiting < 3 )
    {

      if( o.visitedContainer.has( it.node, onNodeJunction ) )
      {

        it.continueUp = false;
        it.visited = true;

        if( o.revisiting < 2 )
        {
          if( onNodeJunction && o.revisiting === 0 )
          o.visitedContainer.appendOnce( it.node );

          if( o.revisiting === 0 )
          if( o.allVariants >= 1 || o.allSiblings >= 1 )
          return true;

          it.continueNode = false;
          return false;
        }

      }

    }

    return true;
  }

  /* */

  function iterationFast( iterator, it )
  {
    let it2 = it;
    it2.visited = false;
    it2.continueNode = true;
    it2.continueUp = true;
    return it2;
  }

  /* */

  function iterationSlow( iterator, it )
  {
    let it2 = Object.create( iterator );
    it2.down = it;
    return it2;
  }

  /* */

  function nodeUp( it )
  {

    // logger.log( _.strDup( '  ', it.level ) + ' up ' + it.node.name );

    if( o.onUp )
    o.onUp( it.node, it );

    if( o.onNode )
    if( it.continueNode )
    o.onNode( it.node, it );

  }

  /* */

  function nodeDown( it )
  {

    // logger.log( _.strDup( '  ', it.level ) + ' down ' + it.node.name );

    if( o.onDown )
    o.onDown( it.node, it );

  }

  /* */

}

lookDfs_body.defaults =
{

  ... _lookDefaults,

  onIteration : null,

}

let lookDfs = _.routine.uniteCloning_replaceByUnite( _look_head, lookDfs_body );

//

function lookCfs_body( o )
{
  let group = this;
  let sys = group.sys;

  if( o.allVariants === null )
  o.allVariants = o.revisiting === 0 ? 0 : 1;
  if( o.allSiblings === null )
  o.allSiblings = o.revisiting === 0 ? 0 : 1;
  _.assert( 0 <= o.allVariants && o.allVariants <= 2 );
  _.assert( 0 <= o.allSiblings && o.allSiblings <= 2 );

  _.routine.assertOptions( lookCfs_body, o );

  let onNodeJunction = o.onNodeJunction === null ? group.onNodeJunction : o.onNodeJunction;
  let allDirect = o.left ? 'allLeft' : 'allRight';
  let allRevert = o.left ? 'allRight' : 'allLeft';

  let iterator = o;
  iterator.iterator = iterator;
  iterator.options = o;
  iterator.visitedContainer = o.visitedContainer;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.continueNode = true;
  iterator.visited = false;
  iterator.result = null;
  iterator.level = -1;

  if( o.onBegin )
  o.onBegin( iterator );

  iterator.node = null;
  iterator.index = null;
  elementsIterate( iterator, o.roots );

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function elementsIterate( it, outNodes )
  {

    if( o.visitedContainer )
    if( o.revisiting === 1 || o.revisiting === 2 )
    if( it.level >= 0 )
    o.visitedContainer.push( it.node );

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;
      let continueNode = it.continueNode;
      let continueUp = it.continueUp;
      let nodesStatus = new HashMap;
      let outNodes2 = outNodes;

      if( o.revisiting === 0 )
      outNodes2 = sys.ContainerAdapterFrom( [] );

      outNodes[ allDirect ]( ( node, n ) => head( node, n, it, level, nodesStatus, outNodes2 ) );
      outNodes2.all( ( node, n ) => post( node, it, nodesStatus ) );

      it.level = level;
      it.node = node;
      it.index = index;
      it.visited = visited;
      it.continueNode = continueNode;
      it.continueUp = continueUp;
    }

    handleDown( it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    if( it.level >= 0 )
    {
      o.visitedContainer.popStrictly( it.node );
    }

  }

  /* */

  function head( node, n, it, level, nodesStatus, outNodes2 )
  {

    it.level = level + 1;
    it.node = node;
    it.index = n;
    it.continueNode = true;
    it.continueUp = true;
    it.visited = false;

    if( o.revisiting < 3 )
    if( o.visitedContainer.has( node, onNodeJunction ) )
    {
      it.visited = true;
      if( o.revisiting === 2 )
      {
        it.continueUp = false;
      }
      else
      {
        it.continueUp = false;
        it.continueNode = false;
      }
      if( o.revisiting === 0 )
      {
        if( onNodeJunction )
        o.visitedContainer.appendOnce( it.node );
        return true;
      }
    }

    if( o.revisiting === 0 )
    outNodes2.append( node );

    if( o.revisiting < 2 && !it.continueUp )
    {
      nodesStatus.set( node, [ it.continueUp, it.continueNode, it.visited, it.level, it.index ] );
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

    nodesStatus.set( node, [ it.continueUp, it.continueNode, it.visited, it.level, it.index ] );

    if( !it.iterator.continue )
    return false;
    return true;
  }

  /* */

  function post( node, it, nodesStatus )
  {
    [ it.continueUp, it.continueNode, it.visited, it.level, it.index ] = nodesStatus.get( node );
    if( o.revisiting < 2 && !it.continueNode )
    return true;

    it.node = node;

    elementsIterate( it, group.nodeOutNodesFor( it.node ) );

    if( !it.iterator.continue )
    return false;
    return true;
  }

  /* */

  function handleUp( it )
  {

    if( it.continueNode )
    if( o.onUp )
    o.onUp( it.node, it );

    if( it.continueNode )
    if( o.onNode )
    o.onNode( it.node, it );

  }

  /* */

  function handleDown( it )
  {

    if( o.onDown && it.level >= 0 )
    o.onDown( it.node, it );

  }

  /* */
}

lookCfs_body.defaults =
{

  ... _lookDefaults,

}

let lookCfs = _.routine.uniteCloning_replaceByUnite( _look_head, lookCfs_body );

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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function dagTopSortDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let ordering = [];
  let visitedContainer = sys.ContainerAdapterFrom( new Set );

  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node ) =>
  {
    if( visitedContainer.has( node, group.onNodeJunction ) )
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
    outNodes = outNodes.filter( ( node2 ) => !visitedContainer.has( node2, group.onNodeJunction ) ? node2 : undefined );
    if( outNodes.length === 0 )
    ordering.push( node );
  }

}

var routine = dagTopSortDfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function each_head( routine, args )
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

  _.routine.options_( routine, o );

  if( o.result === null )
  o.result = [];
  o.result = group.asNodesAdapter( o.result );

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
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookCfs, but got' + _.entity.strType( o.method )
  );
  _.assert
  (
    o.method === group.lookBfs || o.method === group.lookDfs || o.method === group.lookCfs ,
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookCfs, but got' + _.entity.strType( o.method )
  );

  return o;
}

//

function each_body( o )
{
  let group = this;
  let sys = group.sys;

  _.routine.assertOptions( each, o );
  _.assert( sys.ContainerIs( o.result ) );

  let o2 = _.mapOnly_( null, o, o.method.defaults );
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
    it.iterator.result = o.result;
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

let each = _.routine.uniteCloning_replaceByUnite( each_head, each_body );

let eachBfs = _.routine.uniteCloning_replaceByUnite( each_head, each_body );
var defaults = eachBfs.defaults;
defaults.method = lookBfs;

let eachDfs = _.routine.uniteCloning_replaceByUnite( each_head, each_body );
var defaults = eachDfs.defaults;
defaults.method = lookDfs;

let eachCfs = _.routine.uniteCloning_replaceByUnite( each_head, each_body );
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function topSortLeastDegreeBfs( nodes )
{
  let group = this;
  let sys = group.sys;

  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let sources = group.leastIndegreeOnlyAmong( nodes );
  let layers = group.lookBfs({ roots : sources });
  return _.arrayFlatten( layers );
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

  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !nodes.length )
  return nodes.make().original;

  /* */

  let collection = group.nodesStronglyConnectedCollection( nodes );
  let sources1 = collection.nodes.filter( ( node ) => collection.group.nodeIndegree( node ) === 0 ? node : undefined );
  let sources2 = sources1.flatFilter( ( node ) => node.originalNodes );
  collection.finit();

  let layers = group.lookBfs({ roots : sources2 });

  return _.arrayFlatten( layers );
}

var routine = topSortCycledSourceBasedFastBfs;

var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

//

function topSortCycledSourceBasedPrecise( nodes )
{
  let group = this;
  let sys = group.sys;

  nodes = group.asNodesAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !nodes.length )
  return nodes.make().original;

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

  let frontier = sys.ContainerAdapterFrom( new Set() );
  let result = [];
  layers2.each( ( layer ) =>
  {
    let prev;
    let added = sys.ContainerAdapterFrom( new Set() );
    let nodeToInNodes = new HashMap();
    let nodeToOutNodes = new HashMap();
    // let close = layer.make().only( frontier ); /* xxx : only does not work properly */
    let close = layer.make().only( _.self, frontier );

    layer.each( ( node ) => nodeToInNodes.set( node, group.nodeInNodesFor( node ).only( null, layer ).but( _.self, result ) ) );
    layer.each( ( node ) => nodeToOutNodes.set( node, group.nodeOutNodesFor( node ).only( null, layer ).but( _.self, result ) ) );

    while( layer.length )
    {

      while( close.length )
      {
        close
        .least( ( node ) => nodeToInNodes.get( node ).length )
        .most( ( node ) => nodeToOutNodes.get( node ).length )
        .each( ( node ) =>
        {
          add( node );
        });
      }
      if( layer.length )
      layer
      .least( ( node ) => nodeToInNodes.get( node ).length )
      .most( ( node ) => nodeToOutNodes.get( node ).length )
      .first( ( node ) => add( node ) );

    }

    // if( !layer.any( ( node ) => addFastMaybe( node ) ) )
    // {
    //   layer.most( ( node ) => nodeToOutNodes.get( node ).length ).first( ( node ) => add( node ) );
    // }
    //
    // while( layer.length )
    // {
    //   // debugger;
    //   // _.assert( _.all( group.nodeOutNodesFor( prev ).map( ( node ) =>
    //   // {
    //   //   debugger;
    //   //   _.assert( layer.has( node ), () => `Current layer does not have node ${group.nodeToName( node )}` );
    //   // })));
    //   debugger;
    //   let prevOut = nodeToOutNodes.get( prev );
    //   prevOut.any( ( node2 ) =>
    //   // if( !prevOut.first( ( node2 ) => addFastMaybe( node2 ) ) )
    //   {
    //     if( !layer.has( node2 ) )
    //     return false;
    //     if( !addFastMaybe( node2 ) )
    //     {
    //       _.assert( added.length > 0 );
    //       added.empty();
    //       layer.most( ( node ) => nodeToOutNodes.get( node ).length ).first( ( node ) =>
    //       {
    //         add( node );
    //       });
    //       return true;
    //     }
    //     return false;
    //   });
    //
    // }
    //
    // function addFastMaybe( node )
    // {
    //   let inNodes = nodeToInNodes.get( node );
    //   if( !inNodes.length )
    //   return add( node );
    //   else
    //   return false;
    // }

    function add( node )
    {
      _.assert( !!node );
      let outNodes = group.nodeOutNodesFor( node );
      added.append( node );
      result.push( node );
      layer.removeOnceStrictly( node );
      close.removeOnce( node );
      frontier.appendContainerOnce( outNodes );
      close.appendContainerOnce( outNodes.only( null, layer ) );
      nodeToOutNodes.get( node ).each( ( node2 ) => nodeToInNodes.get( node2 ).removeOnce( node ) );
      nodeToInNodes.get( node ).each( ( node2 ) => nodeToOutNodes.get( node2 ).removeOnce( node ) );
      prev = node;
      return true;
    }

  });

  return result;
}

var routine = topSortCycledSourceBasedPrecise;

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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function pairIsConnectedDfs( pair )
{
  let group = this;
  let sys = group.sys;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visitedAdapter1 = sys.ContainerAdapterFrom( new Set() );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  let r = group.lookDfs
  ({
    roots : node1,
    visitedContainer : visitedAdapter1,
    revisiting : 0,
    fast : 1,
    onUp : onUp1,
    onBegin,
  });

  if( r )
  return true;

  return group.lookDfs
  ({
    roots : node2,
    revisiting : 0,
    fast : 1,
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
      it.iterator.result = true;
    }

  }

  /* */

  function onUp2( node, it )
  {

    if( node === node1 || visitedAdapter1.has( node, group.onNodeJunction ) )
    {
      it.iterator.continue = false;
      it.iterator.result = true;
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function pairIsConnectedStronglyDfs( pair )
{
  let group = this;
  let sys = group.sys;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visitedAdapter1 = sys.ContainerAdapterFrom( new Set() );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  let r = group.lookDfs
  ({
    roots : node1,
    visitedContainer : visitedAdapter1,
    revisiting : 0,
    fast : 1,
    onUp : onUp1,
    onBegin,
  });

  if( !r )
  return false;

  return group.lookDfs
  ({
    roots : node2,
    revisiting : 0,
    fast : 1,
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
      it.iterator.result = true;
    }

  }

  /* */

  function onUp2( node, it )
  {

    if( node === node1 || visitedAdapter1.has( node, group.onNodeJunction ) )
    {
      it.iterator.continue = false;
      it.iterator.result = true;
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
 * @class wAbstractNodesGroup
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function nodesConnectedLayersDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let groups = [];
  let visitedContainer = sys.ContainerAdapterFrom( new Set );

  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node ) =>
  {
    if( visitedContainer.has( node, group.onNodeJunction ) )
    return;
    groups.push( [] );
    group.lookDfs
    ({
      roots : node,
      onUp : handleUp,
      revisiting : 0,
      fast : 1,
      visitedContainer : visitedContainer,
    });
  });

  return groups;

  /* */

  function handleUp( node, it )
  {
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

  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onNodeInNodes )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.each( ( node ) =>
  {
    if( visited1.has( node, group.onNodeJunction ) )
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
      fast : 1,
    });
  });

  /* collect layers */

  group.reverse();

  visited1.eachRight( ( node, i ) =>
  {
    if( visited2.has( node, group.onNodeJunction ) )
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
    if( visited1.has( node, group.onNodeJunction ) )
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
      _.assert
      (
          visited1.has( node, group.onNodeJunction )
        , () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}`
      );
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
  let junctionToNodes;

  nodes = group.asNodesAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.onNodeJunction )
  {
    junctionToNodes = new HashMap();
    nodes.each( ( node ) =>
    {
      let junction = group.nodeJunction( node ); /* qqq : implement test routine *Junction for nodesStronglyConnectedCollectionDfs */
      if( !junctionToNodes.has( junction ) )
      junctionToNodes.set( junction, [ node ] )
      else
      junctionToNodes.set( junction, _.arrayAppend( junctionToNodes.get( junction ), node ) )
    });
  }

  if( group.direct && !group.onNodeInNodes )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.each( ( node ) =>
  {
    if( visited1.has( node, group.onNodeJunction ) )
    {
      _.assert( visited1.has( node ), 'All nodes of the junction should be in the list so far' );
      return;
    }
    /*
      both visited1 and visitedContainer made with revisiting : 0 are required
      visitedContainer ( filled by DFS ) tracks visited nodes on up
      visited1 tracks visited nodes on down
      third container visited2 filled by DFS
    */
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp1,
      onDown : handleDown1,
      revisiting : 0, /* revisiting cant be 3 */
      allVariants : 1,
    });
  });

  /* make new graph */

  let group2 = sys.nodesGroupDifferent
  ({
    onNodeOutNodes : group._NodesFromFieldOutNodes,
    onNodeInNodes : group._NodesFromFieldInNodes,
  });
  let collection2 = sys.nodesCollection({ group : group2 });

  /* collect layers */

  group.reverse();

  visited1.eachRight( ( node, i ) =>
  {

    if( group.onNodeJunction )
    {
      if( visited2.has( node, group.onNodeJunction ) )
      {
        if( fromOriginal.has( node ) )
        return;
        let node2 = visited2.left( node, group.onNodeJunction ).element;
        let dnode2 = fromOriginal.get( node2 );
        _.assert( !!dnode2 );
        dnode2.originalNodes.appendOnce( node );

        // if( dnode2.originalNodes.has( '::z', ( a, b ) => _.strEnds( a.absoluteName, b ) ) )
        // debugger;

        fromOriginal.set( node, dnode2 );
        return;
      }
    }
    else
    {
      if( visited2.has( node ) )
      return;
    }

    let dnode = dnodeMake();
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( dnode ),
      visitedContainer : visited2,
      revisiting : 0,
      allVariants : 1,
    });
  });

  /* add edges */

  collection2.nodes.each( ( dnode, l ) =>
  {
    dnode.originalOutNodes.each( ( node, t ) =>
    {

      _.assert
      (
        nodes.has( node ),
        () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}`
      );

      if( dnode.originalNodes.has( node, group.onNodeJunction ) )
      return;
      let dnode2 = fromOriginal.get( node );
      _.assert( !!dnode2 );
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
    // if( node.id === 920 )
    // debugger;
    _.assert( nodes.has( node ) );
    if( visited1.has( node, group.onNodeJunction ) )
    {
      _.assert( visited1.has( node ), 'All nodes of the junction should be in the list so far' );
      it.continueUp = false;
      return;
    }
  }

  /* */

  function handleDown1( node, it )
  {
    // if( node.id === 920 )
    // debugger;
    if( !it.continueUp )
    return;
    if( group.onNodeJunction )
    {
      /* zzz : use appendContainerOnceStrictly later */
      visited1.appendContainerOnce( junctionToNodes.get( group.nodeJunction( node ) ) );
      // visited1.appendContainerOnceStrictly( junctionToNodes.get( group.nodeJunction( node ) ) );
    }
    else
    {
      visited1.appendOnceStrictly( node );
    }
    _.assert
    (
        nodes.has( node, group.onNodeJunction )
      , () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}`
    );
  }

  /* */

  function handleUp2_functor( dnode )
  {
    return function handleUp2( node, it )
    {
      // if( node.id === 920 )
      // debugger;

      _.assert( node === it.node );
      _.assert
      (
        nodes.has( node ),
        () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}`
      );
      _.assert
      (
        visited1.has( node ),
        () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}`
      );
      fromOriginal.set( node, dnode );
      dnode.originalNodes.push( node );

      // if( dnode.originalNodes.has( '::z', ( a, b ) => _.strEnds( a.absoluteName, b ) ) )
      // debugger;

      dnode.originalOutNodes.appendContainer( group.nodeOutNodesFor( node ) );
    }
  }

  /* */

}

var routine = nodesStronglyConnectedCollectionDfs;
var properties = routine.properties = Object.create( null );
routine.input = '(*Node)';
properties.forCollection = 1;

// --
// etc
// --

function _NameFromFieldName( node )
{
  return node.name;
}

//

function _IsDefinedNotNull( node )
{
  if( node === null || node === undefined )
  return false;
  return _.maybe;
}

//

function _inNodesFromGroupCache( node )
{
  let group = this;
  let outNodes = group._inNodesCacheHash.get( group.nodeJunction( node ) );
  _.assert( _.containerAdapter.is( outNodes ), `No cache for the ${group.nodeToQualifiedName( node )}` );
  return outNodes;
}

//

function _NodesFromFieldNodes( node )
{
  return node.nodes;
}

//

function _NodesFromFieldOutNodes( node )
{
  return node.outNodes;
}

//

function _NodesFromFieldInNodes( node )
{
  return node.inNodes;
}

// --
// relations
// --

let directSymbol = Symbol.for( 'direct' );

let Composes =
{
  direct : true,
  collections : _.define.own([]),
}

let Aggregates =
{

  onNodeIs : _IsDefinedNotNull,
  onNodeName : _NameFromFieldName,
  onNodeQualifiedName : null,
  onNodeOutNodes : _NodesFromFieldNodes,
  onNodeInNodes : null,
  onNodeInfoExport : null,
  onNodeFrom : null,
  onNodeJunction : null, /* qqq : cover by tests */

  onJunctionIs : _IsDefinedNotNull,
  onJunctionName : _NameFromFieldName,
  onJunctionNodes : null,

}

let Associates =
{
  sys : null,
  context : null,
}

let Restricts =
{
  _inNodesCacheHash : null, /* xxx : remove? */
}

let Statics =
{

  _NameFromFieldName,
  _IsDefinedNotNull,

  _NodesFromFieldNodes,
  _NodesFromFieldOutNodes,
  _NodesFromFieldInNodes,

}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
  nodes : 'nodes',
}

let Accessors =
{
  direct : {},
}

// --
// declare
// --

let Extension =
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

  // cache

  cacheInNodesFromOutNodesInvalidate,
  cacheInNodesFromOutNodesOnce,
  cacheInNodesFromOutNodesUpdate,
  cacheInNodesFromOutNodesUpdateNode,
  cacheInNodesExportInfo,
  cachesInvalidate,

  // export

  optionsExport,
  exportStructure,
  exportString,

  // descriptor

  nodeDescriptorWithNode,
  nodeDescriptorWith,
  nodeDescriptorObtain,
  nodeDescriptorDelete,

  // node

  nodeIs,
  nodesAre : Vectorize( nodeIs ),
  nodesAreAll : VectorizeAll( nodeIs ),
  nodesAreAny : VectorizeAny( nodeIs ),
  nodesAreNone : VectorizeNone( nodeIs ),

  nodeToName,
  nodesToNames : Vectorize( nodeToName ),
  nodeToNameTry,
  nodesToNamesTry : Vectorize( nodeToNameTry ),
  nodeToQualifiedName,
  nodesToQualifiedNames : Vectorize( nodeToQualifiedName ),
  nodeToQualifiedNameTry,
  nodesToQualifiedNamesTry : Vectorize( nodeToQualifiedNameTry ),

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
  nodeJunction,
  nodesJunctions : Vectorize( nodeJunction ),

  // node exporter

  nodeDataExport,
  nodesDataExport : Vectorize( nodeDataExport ),
  nodeInfoExport,
  nodesInfoExport,
  rootsExportInfoTree,

  // junction

  junctionIs,
  junctionsAre : Vectorize( junctionIs ),
  junctionsAreAll : VectorizeAll( junctionIs ),
  junctionsAreAny : VectorizeAny( junctionIs ),
  junctionsAreNone : VectorizeNone( junctionIs ),

  junctionToName,
  junctionsToNames : Vectorize( junctionToName ),
  junctionNodes,
  junctionsNodes : Vectorize( junctionNodes ),

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
  // look,
  // look : lookDfs,
  /* qqq xxx : implement method loog with option algorithm : 'dfs' */

  each,
  eachBfs,
  eachDfs,
  eachCfs,

  // orderer

  dagTopSortDfs,
  dagTopSort : dagTopSortDfs,
  topSortLeastDegreeBfs,
  topSortCycledSourceBasedFastBfs,
  topSortCycledSourceBasedPrecise,
  topSort : topSortCycledSourceBasedPrecise,

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

  // defaults

  _NameFromFieldName,
  _IsDefinedNotNull,
  _inNodesFromGroupCache,

  _NodesFromFieldNodes,
  _NodesFromFieldOutNodes,
  _NodesFromFieldInNodes,

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
  extend : Extension,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

_.assert( _.routineIs( _.graph.AbstractNodesGroup.prototype.nodeToQualifiedNameTry ) );

})();
