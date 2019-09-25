( function _NodesGroup_s_( ) {

'use strict';

/**
 * @classdesc Class to operate graph as group of nodes.
 * @class wAbstractNodesGroup
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph
 */

let _ = _global_.wTools;
let Parent = null;
let Self = function wAbstractNodesGroup( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractNodesGroup';

// --
// routine
// --

function init( o )
{
  let group = this;

  group[ nodesSymbol ] = group.containerMake();

  _.workpiece.initFields( group );
  Object.preventExtensions( group );

  _.assert( _.arrayIs( group.nodes ) && group.nodes.length === 0 );

  if( o )
  group.copy( o );

  group.form();

  return group;
}

//

function finit()
{
  let group = this;
  group.unform();
  _.Copyable.prototype.finit.call( group );
}

//

function form()
{
  let group = this;
  _.assert( group.sys instanceof group.System );
  _.arrayAppendOnceStrictly( group.sys.groups, group );
}

//

function unform()
{
  let group = this;
  group.nodesDelete();
  _.arrayRemoveOnceStrictly( group.sys.groups, group );
}

//

function clone()
{
  let group = this;
  let group2 = _.Copyable.prototype.clone.apply( group, arguments );
  return group2;
}

// --
// reverse
// --

function directSet( val )
{
  let group = this;

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

  if( val === undefined )
  val = !group.direct;
  else
  val = !!val;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group.direct === val )
  return group;

  if( !val && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce();

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

function cacheInNodesFromOutNodesOnce( nodes )
{
  let group = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group._inNodesCacheHash )
  return group._inNodesCacheHash;

  return group.cacheInNodesFromOutNodesUpdate( nodes );
}

//

function cacheInNodesFromOutNodesUpdate( nodes )
{
  let group = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  if( !group.onInNodesGet )
  group.onInNodesGet = group.inNodesFromGroupCache;

  if( !group._inNodesCacheHash )
  group._inNodesCacheHash = new HashMap();
  nodes.forEach( ( nodeHandle1 ) =>
  {
    group._inNodesCacheHash.set( nodeHandle1, new Array );
  });

  nodes.forEach( ( nodeHandle1 ) =>
  {
    let directNeighbours = group.nodeOutNodesFor( nodeHandle1 );
    directNeighbours.forEach( ( nodeHandle2 ) =>
    {
      let reverseNeighbours = group._inNodesCacheHash.get( nodeHandle2 );
      _.assert( !!reverseNeighbours, `Cant retrive in nodes of ${group.nodeToQualifiedName( nodeHandle2 )} from cache` );
      reverseNeighbours.push( nodeHandle1 );
    });
  });

  return group._inNodesCacheHash;
}

//

function cachesInvalidate()
{
  let group = this;
  debugger;
  _.assert( 'not tested' );
  if( group._inNodesCacheHash )
  group._inNodesCacheHash.clear();
  group._inNodesCacheHash = null;
  return group;
}

// --
// exporter
// --

function optionsExport()
{
  let group = this;
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

  if( o.nodes === null )
  o.nodes = group.nodes;
  else
  o.nodes = group.nodesAs( o.nodes );

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

  if( o.nodes === null )
  o.nodes = group.nodes;
  else
  o.nodes = group.nodesAs( o.nodes );

  let result = group.nodesInfoExport( o.nodes, o );

  return result;
}

infoExport.defaults =
{
  verbosity : 2,
  nodes : null,
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`.
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorWithId
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDescriptorWithId( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorWithId.apply( sys, arguments );
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
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorObtain
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDescriptorObtain( nodeId )
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
// nodeHandle
// --

/**
 * @summary Returns true if group has provided node. Takes node handle as argument.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeHas
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeHas( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ) );
  return _.arrayHas( group.nodes, nodeHandle, group.onNodeEvaluate || undefined );
}

//

/**
 * @summary Returns true if provided entity `nodeHandle` is a node.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeIs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeIs( nodeHandle )
{
  let group = this;
  return group.onNodeIs( nodeHandle );
}

// --
// nodeHandle
// --

function nodeIndegree( nodeHandle )
{
  let group = this;
  let nodes = group.nodeInNodesFor( nodeHandle );
  return nodes.length;
}

//

function nodeOutdegree( nodeHandle )
{
  let group = this;
  let nodes = group.nodeOutNodesFor( nodeHandle );
  return nodes.length;
}

//

function nodeDegree( nodeHandle )
{
  let group = this;
  let nodes1 = group.nodeInNodesFor( nodeHandle );
  let nodes2 = group.nodeOutNodesFor( nodeHandle );
  return nodes1.length + nodes2.length;
}

//

function nodeOutNodesFor( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ), 'Bad node' );
  _.assert( arguments.length === 1 );
  let result = group.onOutNodesGet( nodeHandle );
  _.assert( _.arrayIs( result ), 'Bad node' );
  return result;
}

//

function nodeInNodesFor( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ), 'Bad node' );
  _.assert( arguments.length === 1 );
  let result = group.onInNodesGet( nodeHandle );
  _.assert( _.arrayIs( result ), 'Bad node' );
  return result;
}

//

function nodeOutNodesIdsFor( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ) );
  _.assert( arguments.length === 1 );

  let result = group.nodesToIds( group.onOutNodesGet( nodeHandle ) );

  _.assert( _.arrayIs( result ) );
  return result;
}

//

function nodeInNodesIdsFor( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ) );
  _.assert( arguments.length === 1 );

  let result = group.nodesToIds( group.onInNodesGet( nodeHandle ) );

  _.assert( _.arrayIs( result ) );
  return result;
}

//

function nodeRefNumber( nodeId )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( !!nodeId, 'Expects node or node id' );
  _.assert( 'not tested' );

  if( !sys.idIs( nodeId ) )
  {
    nodeId = group.nodeToId( nodeId );
  }

  let descriptor = group.nodeDescriptorWithId( nodeId );

  if( !descriptor )
  if( sys.idToNodeHash.has( nodeId ) )
  return 1;
  else
  return 0;

  _.assert( descriptor.count >= 0 );

  return descriptor.count;
}

//

function nodesSet( nodes )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( nodes === null || _.arrayIs( nodes ) );

  group.nodesDelete( group.nodes.slice() );
  if( nodes )
  group.nodesAdd( nodes );

  return group.nodes;
}

//

/**
 * @summary Adds provided node `nodeHandle` to current group.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeAdd
 * @returns {Number} Returns id of added node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

 /**
 * @summary Adds several nodes to the system.
 * @param {Array} nodeHandle Array with node descriptors.
 * @function nodesAdd
 * @returns {Array} Returns array with ids of added nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeAdd( nodeHandle )
{
  let group = this;
  let sys = group.sys;

  _.assert( !!group.nodeIs( nodeHandle ), 'Expects nodeHandle' );
  _.assert( !_.arrayHas( group.nodes, nodeHandle, group.onNodeEvaluate || undefined ), 'The group does not have a node with such nodeHandle' );
  _.arrayAppendOnceStrictly( group.nodes, nodeHandle, group.onNodeEvaluate || undefined );

  let wasDefined = true;
  let id = sys.nodeToIdTry( nodeHandle );
  if( id === undefined )
  {
    id = ++sys.nodeCounter;
    wasDefined = false;
  }

  sys.nodeToIdHash.set( nodeHandle, id );
  sys.idToNodeHash.set( id, nodeHandle );

  if( wasDefined )
  {
    let descriptor = sys.nodeDescriptorObtain( id );
    descriptor.count += 1;
  }

  return id;
}

//

/**
 * @summary Removes node `nodeHandle` from current group.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeDelete
 * @returns {Number} Returns id of removed node.
 * @throws {Error} If system doesn't have node with such `nodeHandle`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDelete( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  let id = sys.nodeToId( nodeHandle );
  let descriptor = group.nodeDescriptorWith( nodeHandle );

  _.assert( !!group.nodeIs( nodeHandle ), 'Expects nodeHandle' );
  _.assert( descriptor === null || descriptor.count > 0, 'The system does not have information about number of the node' );
  _.assert( _.arrayHas( group.nodes, nodeHandle, group.onNodeEvaluate || undefined ), 'The group does not have a node with such nodeHandle' );
  _.arrayRemoveOnceStrictly( group.nodes, nodeHandle, group.onNodeEvaluate || undefined );

  if( descriptor && descriptor.count > 1 )
  {
    descriptor.count -= 1;
  }
  else
  {
    sys.nodeToIdHash.delete( nodeHandle );
    sys.idToNodeHash.delete( id );
    sys.nodeDescriptorDelete( id );
  }

  return id;
}

//

/**
 * @summary Removes several nodes from system.
 * @param {Array} nodeHandle Array with node descriptors.
 * @function nodesDelete
 * @returns {Array} Returns array with ids of removed nodes.
 * @throws {Error} If system doesn't have node with such `nodeHandle`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

let _nodesDelete = _.vectorize( nodeDelete );
function nodesDelete()
{
  let group = this;
  if( arguments.length === 0 )
  return group.nodesDelete( group.nodes.slice() );
  return _nodesDelete.apply( this, arguments );
}

//

function nodeDataExport( nodeHandle )
{
  let group = this;

  _.assert( group.nodeIs( nodeHandle ) );

  let result = Object.create( null );
  result.id = group.nodeToId( nodeHandle );
  result.outNodeIds = group.nodesToIdsTry( group.nodeOutNodesFor( nodeHandle ) );

  return result;
}

//

function nodeInfoExport( node, opts )
{
  let group = this;

  // let data = group.nodeDataExport( node );
  // let result = group.nodeToName( node ) + ' : ';
  // let outNames = group.nodesToNamesTry( group.idsToNodesTry( data.outNodeIds ) );
  // result += outNames.join( ' ' );

  if( group.onNodeInfoExport )
  debugger;
  if( group.onNodeInfoExport )
  return group.onNodeInfoExport( node, o );

  let name = group.nodeToName( node );
  let outNames = group.nodesToNames( group.nodeOutNodesFor( node ) );

  let result = name + ' : ' + outNames.join( ' ' );
  return result;
}

//

function nodesInfoExport( nodes, opts )
{
  let group = this;
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 )

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  let result = nodes.map( ( node ) => group.nodeInfoExport( node, opts ) );
  result = result.join( '\n' );
  return result;
}

//

function nodesExportInfoTree( nodes, opts )
{
  let group = this;
  let result = '';
  let prevIt;
  let lastNodes;
  let tab;

  opts = _.routineOptions( nodesExportInfoTree, opts );

  _.assert( opts.dtab1.length === opts.dtab2.length );
  _.assert( _.arrayIs( nodes ) );

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.forEach( ( node, i ) =>
  {
    lastNodes = Object.create( null );
    tab = '';

    if( opts.rootsDelimiting && i > 0 )
    result += opts.linePrefix + opts.dtab1 + opts.linePostfix;

    prevIt = { level : 0 };
    group.lookDfs
    ({
      roots : node,
      onBegin : handleBegin,
      onUp : handleUp1,
      onDown : handleDown1,
      fast : 0,
      revisiting : 1,
    });
    lastNodes[ '0' ] = nodes.length -1 === i;

    prevIt = { level : 0, path : [] };
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

  function handleBegin( it )
  {
    it.path = [];
  }

  /* */

  function handleUp1( node, it )
  {
    it.path = it.prev.path.slice();
    it.path.push( it.index );
  }

  /* */

  function handleDown1( node, it )
  {
    let dLevel = it.level - prevIt.level;
    if( dLevel < 0 )
    lastNodes[ prevIt.path.join( '/' ) ] = true;
    prevIt = it;
  }

  /* */

  function handleUp2( node, it )
  {
    it.path = it.prev.path.slice();
    it.path.push( it.index );

    let isLast = !!lastNodes[ prevIt.path.join( '/' ) ];
    let dLevel = it.level - prevIt.level;
    let name = group.nodeToName( node );

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
    // _.assert( it.index === it.path[ it.path.length-1 ] );
    // it.path.pop();
  }

}

nodesExportInfoTree.defaults =
{
  linePrefix : ' ',
  linePostfix : '\n',
  tabPrefix : '',
  tabPostfix : '+-- ',
  dtab1 : '| ',
  dtab2 : '  ',
  rootsDelimiting : 1,
}

//

/**
 * @summary Returns qualified name of node. Takes single argument - a node.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeToQualifiedName
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToQualifiedName( node )
{
  let group = this;
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
 * @summary Returns name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToName
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToName( node )
{
  let group = this;
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

//

function nodeToNameTry( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  if( !group.nodeIs( nodeHandle ) )
  return undefined;
  _.assert( arguments.length === 1 );
  return group.nodeToName( nodeHandle );
}

//

/**
 * @summary Returns id of node. Takes single argument - a node.
 * @description Returns undefined if can't get id of provided node.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeToIdTry
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToIdTry( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeToIdTry( nodeHandle );
}

//

/**
 * @summary Returns id of node. Takes single argument - a node.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeToId
 * @throws {Error} If can't get id of provided node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToId( node )
{
  let group = this;
  let sys = group.sys;

  if( group.onNodeIdGet )
  return group.onNodeIdGet( node );

  return sys.nodeToId( node );
}

//

function idToNodeTry( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.idToNodeTry( nodeId );
}

//

function idToNode( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.idToNode( nodeId );
}

//

function idToName( nodeId )
{
  let group = this;
  let node = group.idToNode( nodeId );
  return group.nodeToName( node );
}

// --
// filter
// --

function leastIndegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = Infinity;

  nodes.forEach( ( node ) =>
  {
    let d = group.nodeIndegree( node );
    if( d < result )
    result = d;
  });

  if( result === Infinity )
  result = 0;

  return result;
}

//

function mostIndegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = 0;

  nodes.forEach( ( node ) =>
  {
    let d = group.nodeIndegree( node );
    if( d > result )
    result = d;
  });

  return result;
}

//

function leastOutdegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  // if( !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce( nodes );

  let result = Infinity;

  nodes.forEach( ( node ) =>
  {
    let d = group.nodeOutdegree( node );
    if( d < result )
    result = d;
  });

  if( result === Infinity )
  result = 0;

  return result;
}

//

function mostOutdegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  // if( !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce( nodes );

  let result = 0;

  nodes.forEach( ( node ) =>
  {
    let d = group.nodeOutdegree( node );
    if( d > result )
    result = d;
  });

  return result;
}

//

function leastIndegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.leastIndegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeIndegree( node ) === degree );
  return result;
}

//

function mostIndegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.mostIndegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeIndegree( node ) === degree );
  return result;
}


//

function leastOutdegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.leastOutdegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeOutdegree( node ) === degree );
  return result;
}

//

function mostOutdegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.mostOutdegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeOutdegree( node ) === degree );
  return result;
}

//

function sourcesOnlyAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = nodes.filter( ( node ) => group.nodeInNodesFor( node ).length === 0 );

  return result;
}

//

function sinksOnlyAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  // _.assert( group.nodesAreAll( nodes ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = nodes.filter( ( node ) => group.nodesOutNodesFor( node ).length === 0 );

  return result;
}

// --
// helper
// --

/**
 * @summary Find all nodes reachable from specified roots.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function rootsAllReachable
 * @return {Array of Node|Set of Node} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function rootsAllReachable( dstRoots, srcRoots )
{
  let group = this;

  if( group.nodeIs( dstRoots ) )
  {
    dstRoots = group.nodesAs( dstRoots );
  }

  if( srcRoots === undefined )
  {
    if( dstRoots )
    srcRoots = dstRoots;
    else
    srcRoots = group.nodes;
  }
  else
  {
    srcRoots = group.nodesAs( srcRoots );
  }

  if( dstRoots === null )
  {
    if( _.arrayIs( srcRoots ) )
    dstRoots = [];
    else
    dstRoots = new Set;
    // dstRoots = group.containerMake();
  }

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( _.arrayIs( dstRoots ) || _.setIs( dstRoots ) );
  _.assert( _.arrayIs( srcRoots ) || _.setIs( srcRoots ) );

  // if( srcRoots === dstRoots )
  // srcRoots = _.make( dstRoots );

  if( _.arrayIs( srcRoots ) )
  group.lookDfs({ roots : srcRoots, onUp : handleArray });
  else
  group.lookDfs({ roots : srcRoots, onUp : handleSet });

  return dstRoots;

  function handleArray( node )
  {
    _.arrayAppendOnce( dstRoots, node );
  }

  function handleSet( node )
  {
    dstRoots.add( node );
  }

}

//

/**
 * @summary Find all nodes either reachable from specified roots or nodes which can reach specified.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function rootsAll
 * @return {Array of Node|Set of Node} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function rootsAll( dstRoots, srcRoots )
{
  let group = this;

  if( group.nodeIs( dstRoots ) )
  {
    dstRoots = group.nodesAs( dstRoots );
  }

  if( srcRoots === undefined )
  {
    if( dstRoots )
    srcRoots = dstRoots;
    else
    srcRoots = group.nodes;
  }
  else
  {
    srcRoots = group.nodesAs( srcRoots );
  }

  if( dstRoots === null )
  {
    if( _.arrayIs( srcRoots ) )
    dstRoots = [];
    else
    dstRoots = new Set;
  }

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( _.arrayIs( dstRoots ) || _.setIs( dstRoots ) );
  _.assert( _.arrayIs( srcRoots ) || _.setIs( srcRoots ) );

  // if( srcRoots === dstRoots )
  // srcRoots = _.make( dstRoots );

  if( _.arrayIs( srcRoots ) )
  group.lookDfs({ roots : srcRoots, onUp : handleArray });
  else
  group.lookDfs({ roots : srcRoots, onUp : handleSet });

  return dstRoots;

  function handleArray( node )
  {
    _.arrayAppendOnce( dstRoots, node );
  }

  function handleSet( node )
  {
    dstRoots.add( node );
  }

}

//

/**
 * @summary Put node in a Set if not put yet in a Set or Long.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function nodesAs
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesAs( nodes )
{
  let group = this;

  if( !_.longIs( nodes ) && !_.setIs( nodes ) )
  {
    _.assert( group.nodeIs( nodes ) )
    nodes = _.arrayAs( nodes );
  }

  return nodes;
}

//

/**
 * @summary Check is argument allowed container either wrap of container.
 *
 * @function containerIs
 * @return {boolean} True if it is such thing.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function containerIs( src )
{
  if( _.arrayLike( src ) || _.setLike( src ) )
  return true;
  if( src instanceof ContainerWrap )
  return true;
  return false;
}

//

/**
 * @summary Make container for nodes.
 *
 * @function containerMake
 * @return {Container} Return new empty container for node. Empty Array by default.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function containerMake()
{
  _.assert( arguments.length === 0 );
  return new Array;
}

//

/**
 * @summary Make wrap of a container for similar fast access to elements.
 *
 * @function containerAdapter
 * @return {ContainerWrap} Return ContainerWrap not making a new one if passed in is such.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function containerAdapter( container )
{
  _.assert( arguments.length === 1 );
  if( container instanceof SetWrap || container instanceof ArrayWrap )
  {
    return container;
  }
  else if( _.setIs( container ) )
  {
    return new SetWrap( container );
  }
  else if( _.arrayIs( container ) )
  {
    return new ArrayWrap( container );
  }
  else _.assert( 0, 'Unknown type of container' );
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
 *
 * @function lookBfs
 * @return {Array} Returns array of layers that are reachable from provided nodes `o.roots`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function lookBfs( o )
{
  let group = this;

  _.routineOptions( lookBfs, o );

  o.roots = group.nodesAs( o.roots );

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = group.containerMake();

  if( Config.debug )
  {
    _.assert( arguments.length === 1 );
    _.assert( group.nodesAreAll( o.roots ) );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( o.roots.every( ( node ) => group.nodeIs( node ) ) );
  }

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.layers = [];
  iterator.level = 0;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.continueNode = true;
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
    let nodes2 = [];
    let nodesStatus = [];

    /*
      0 - not visiting
      1 - not including
      2 - not going up
      3 - visit, include, go up
    */

    if( o.onLayerUp )
    o.onLayerUp( nodes, it );

    let itContinueUp = it.continueUp;
    let itContinueNode = it.continueNode;

    if( it.iterator.continue )
    nodes.every( ( nodeHandle, k ) =>
    {
      let visited;
      if( o.revisiting === 2 )
      {
        visited = _.arrayCountElement( o.visitedContainer, nodeHandle, group.onNodeEvaluate || undefined );
        if( visited > 1 )
        {
          nodesStatus[ k ] = 0;
          return true;
        }
      }
      else if( o.revisiting < 2 )
      {
        if( _.arrayHas( o.visitedContainer, nodeHandle, group.onNodeEvaluate || undefined ) )
        {
          nodesStatus[ k ] = 0;
          return true;
        }
      }

      if( o.onUp )
      o.onUp( nodeHandle, it );

      if( it.continueNode )
      if( o.onNode )
      o.onNode( nodeHandle, it );

      if( !it.continueNode )
      it.continueUp = false;

      if( it.continueUp )
      {
        if( o.revisiting === 2 )
        {
          if( !visited )
          {
            nodes2.push( nodeHandle );
          }
          if( o.visitedContainer )
          o.visitedContainer.push( nodeHandle );
        }
        else
        {
          nodes2.push( nodeHandle );
          if( o.visitedContainer )
          o.visitedContainer.push( nodeHandle );
        }
      }

      if( it.continueUp )
      nodesStatus[ k ] = 3;
      else if( it.continueNode )
      nodesStatus[ k ] = 2;
      else
      nodesStatus[ k ] = 1;

      it.continueNode = itContinueNode;
      it.continueUp = itContinueUp;

      return it.iterator.continue;
    });

    it.continueUp = itContinueUp;
    it.continueNode = itContinueNode;

    if( !it.continueNode )
    it.continueUp = false;

    if( nodes2.length )
    {
      it.layers.push( nodes2 );
      visitUp( nodes2, it );
    }

    /* */

    if( it.iterator.continue )
    nodes.every( ( nodeHandle, k ) =>
    {

      if( !nodesStatus[ k ] )
      return true;

      it.continueUp = true;
      it.continueNode = true;

      if( nodesStatus[ k ] < 3 )
      it.continueUp = false;
      if( nodesStatus[ k ] < 2 )
      it.continueNode = false;

      if( o.onDown )
      o.onDown( nodeHandle, it );

      return true;
    });

    if( o.onLayerDown )
    o.onLayerDown( nodes2, it );

    it.continueUp = true;
  }

  /* */

  function visitUp( nodes2, it )
  {
    let nodes3 = [];

    if( !it.iterator.continue || !it.continueUp )
    return;

    nodes2.every( ( nodeHandle ) =>
    {
      let outNodes = group.nodeOutNodesFor( nodeHandle );
      _.arrayAppendArray( nodes3, outNodes );
      return true;
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

  _.routineOptions( lookDfs, o );

  o.roots = group.nodesAs( o.roots );
  o.roots = group.containerAdapter( o.roots );

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = group.containerMake();
  if( o.visitedContainer )
  o.visitedContainer = group.containerAdapter( o.visitedContainer );

  _.assert( arguments.length === 1 );
  _.assert( 0 <= o.revisiting && o.revisiting <= 3 );

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
    /* xxx : replace all "every" wth _.all to make it working for Sets of nodes */
    o.roots.all( ( node, index ) =>
    {
      iterator.node = node;
      iterator.index = index;
      visitFast( iterator )
      return iterator.continue;
    });
  }
  else
  {
    o.roots.all( ( node, index ) =>
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
      if( o.revisiting !== 1 || o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );

    }

    let level = it.level + 1;

    if( it.iterator.continue && it.continueUp )
    {
      let outNodes = group.nodeOutNodesFor( it.node );
      for( let n = 0 ; n < outNodes.length ; n++ )
      {

        let node = outNodes[ n ];
        let it2 = Object.create( iterator );
        it2.node = node;
        it2.index = n;
        it2.prev = it;
        it2.level = level;
        it2.visited = false;
        it2.continueNode = true;

        visitSlow( it2 );
        _.assert( !_.mapOwnKey( it2, 'continue' ) );
      }
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
      if( o.revisiting !== 1 || o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );

    }

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;
      let outNodes = group.nodeOutNodesFor( it.node );

      for( let n = 0 ; n < outNodes.length ; n++ )
      {
        it.node = outNodes[ n ];
        it.index = n;
        it.level = level + 1;
        it.visited = false;
        visitFast( it );
        if( !it.iterator.continue )
        break;
      }

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

  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,

}

//

function lookDbfs( o )
{
  let group = this;

  _.routineOptions( lookDbfs, o );

  o.roots = group.nodesAs( o.roots );
  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = group.containerMake();

  if( Config.debug )
  {
    _.assert( arguments.length === 1 );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( group.nodesAreAll( o.roots ) );
  }

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

  o.roots.every( ( node, index ) =>
  {
    iterator.node = node;
    iterator.index = index;
    visitFirstFast( iterator );
    visitSecondFast( iterator );
    return iterator.continue;
  });

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visitSecondFast( it )
  {

    if( o.visitedContainer )
    if( o.revisiting === 1 || o.revisiting === 2 )
    o.visitedContainer.push( it.node );

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;

      let outNodes = group.nodeOutNodesFor( it.node );
      let status = [];
      /*
        0 - not visiting
        1 - not including
        2 - not going up
        3 - visit, include, go up
      */

      for( let n = 0 ; n < outNodes.length ; n++ )
      {

        let node = outNodes[ n ];
        status[ n ] = 3;

        // if( o.revisiting < 3 )
        // if( _.arrayHas( o.visitedContainer, node ) )
        // status[ n ] = _.arrayHas( o.visitedContainer, node ) ? 0 : 3;
        if( o.revisiting < 3 )
        if( _.arrayHas( o.visitedContainer, node, group.onNodeEvaluate || undefined ) )
        status[ n ] = 0;

        if( o.revisiting < 2 && !status[ n ] )
        continue;

        it.level = level+1;
        it.node = outNodes[ n ];
        it.index = n;
        it.visited = false;
        if( o.revisiting === 2 && !status[ n ] )
        {
          it.visited = true;
          it.continueUp = false;
        }

        visitFirstFast( it );

        if( status[ n ] > 1 && !it.continueNode )
        status[ n ] = 1;
        if( status[ n ] > 2 && !it.continueUp )
        status[ n ] = 2;

        if( !it.iterator.continue )
        break;

        it.continueNode = true;
        it.continueUp = true;
      }
      for( let n = 0 ; n < outNodes.length ; n++ )
      {
        if( o.revisiting < 2 && !status[ n ] )
        continue;

        it.level = level+1;
        it.index = n;
        it.node = outNodes[ n ];
        it.visited = status[ n ] > 0;
        it.continueNode = status[ n ] > 1;
        it.continueUp = status[ n ] > 2;

        visitSecondFast( it );
        if( !it.iterator.continue )
        break;
      }

      it.level = level;
      it.node = node;
      it.index = index;
      it.visited = visited;
    }

    if( o.onDown )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      _.assert( o.visitedContainer[ o.visitedContainer.length-1 ] === it.node );
      o.visitedContainer.pop( it.node );
    }

    it.continueNode = true;
    it.continueUp = true;
  }

  /* */

  function visitFirstFast( it )
  {

    if( o.visitedContainer )
    if( o.revisiting !== 1 && o.revisiting !== 2 )
    o.visitedContainer.push( it.node );

    if( o.onUp )
    o.onUp( it.node, it );

    if( it.continueNode )
    if( o.onNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    {
      it.continueUp = false;
      if( o.visitedContainer )
      if( o.revisiting !== 1 || o.revisiting !== 2 )
      o.visitedContainer.pop();
    }

  }

}

lookDbfs.defaults =
{

  roots : null,
  visitedContainer : null,

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
  let ordering = [];
  let visitedContainer = group.containerMake(); // xxx : remove?

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.forEach( ( nodeHandle ) =>
  {
    if( _.arrayHas( visitedContainer, nodeHandle, group.onNodeEvaluate || undefined ) )
    return;
    group.lookDfs({ roots : nodeHandle, onDown : handleDown, revisiting : 0 });
  });

  _.assert( ordering.length === nodes.length, 'Seems input graph is not a DAG' );

  return ordering;

  /* */

  function handleDown( nodeHandle, it )
  {
    let outNodes = group.nodeOutNodesFor( nodeHandle );
    outNodes = outNodes.filter( ( nodeHandle2 ) => !_.arrayHas( visitedContainer, nodeHandle2, group.onNodeEvaluate || undefined ) );
    if( outNodes.length === 0 )
    ordering.push( nodeHandle );
    visitedContainer.push( nodeHandle );
  }

}

//

function each_pre( routine, args )
{
  let group = this;
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
  o.result = group.containerMake();

  if( o.roots === undefined || o.roots === null )
  o.roots = group.nodes;
  else
  o.roots = group.nodesAs( o.roots );

  if( Config.debug )
  {
    _.assert( 0 <= o.recursive && o.recursive <= 2 );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( group.nodesAreAll( o.roots ) );
  }

  if( o.method === null )
  o.method = this.lookDbfs;
  if( _.strIs( o.method ) )
  {
    _.assert( _.routineIs( this[ o.method ] ), () => 'Unknown method ' + _.strQuote( o.method ) );
    o.method = this[ o.method ];
  }
  _.assert
  (
    _.routineIs( o.method ),
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookDbfs, but got' + _.strType( o.method )
  );
  _.assert
  (
    o.method === group.lookBfs || o.method === group.lookDfs || o.method === group.lookDbfs ,
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookDbfs, but got' + _.strType( o.method )
  );

  return o;
}

function each_body( o )
{
  let group = this;

  _.assertRoutineOptions( each, o );

  let o2 = _.mapOnly( o, o.method.defaults );

  o2.onNode = handleNode;
  o2.onUp = handleUp;
  o2.onDown = handleDown;
  o2.onBegin = handleBegin;
  o2.onEnd = handleEnd;

  let r = o.method.call( group, o2 );

  return o.result;

  /* */

  function handleNode( node, it )
  {

    if( o.onNode )
    o.onNode.apply( this, arguments );

    if( it.included )
    _.arrayAppend( o.result, node );

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
    if( !o.includingBranches || !o.withTerminals )
    {
      let degree = group.nodeOutdegree( node );
      if( !o.includingBranches && degree > 0 )
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
defaults.includingBranches = 1;

let each = _.routineFromPreAndBody( each_pre, each_body );

let eachBfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachBfs.defaults;
defaults.method = lookBfs;

let eachDfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachDfs.defaults;
defaults.method = lookDfs;

let eachDbfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachDbfs.defaults;
defaults.method = lookDbfs;

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
 * var ordering = group.topSortSourceBasedBfs();
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
 * @function topSortSourceBasedBfs
 * @return {Array} Returns array with sorted layers.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function topSortSourceBasedBfs( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let sources = group.leastIndegreeOnlyAmong( nodes );
  let result = group.lookBfs({ roots : sources });

  return result;
}

//

function topSortCycledSourceBasedBfs( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !nodes.length )
  return group.containerMake();

  let sources = group.containerMake();
  let tree = group.nodesStronglyConnectedTree( nodes );
  tree.nodes.forEach( ( node ) =>
  {
    if( tree.nodeIndegree( node ) === 0 )
    _.arrayAppendArray( sources, node.originalNodes );
  });

  tree.finit();

  _.assert( sources.length > 0 );

  let result = group.lookBfs({ roots : sources });

  return _.arrayFlatten( null, result );
}

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

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.containerAdapter( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];
  let found = false;
  let result = [];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

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

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.containerAdapter( visited );
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

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.containerAdapter( visited );
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

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.containerAdapter( visited );
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
 * @param {Array} nodes Array with node descriptors.]
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
  let groups = [];
  let visitedContainer = group.containerMake(); /* xxx : remove, refactor */

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.forEach( ( nodeHandle ) =>
  {
    let id = group.nodeToId( nodeHandle );
    if( _.arrayHas( visitedContainer, id ) )
    return;
    groups.push( [] );
    group.lookDfs({ roots : nodeHandle, onUp : handleUp });
  });

  return groups;

  /* */

  function handleUp( nodeHandle, it )
  {
    let id = group.nodeToId( nodeHandle );
    visitedContainer.push( id );
    groups[ groups.length-1 ].push( id );
  }

}

//

function nodesStronglyConnectedLayersDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let visited1 = [];
  let visited2 = group.containerMake();
  let layers = [];

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.forEach( ( node ) =>
  {
    if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
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

  for( let i = visited1.length-1 ; i >= 0 ; i-- )
  {
    let node = visited1[ i ];
    if( _.arrayHas( visited2, node, group.onNodeEvaluate || undefined ) )
    continue;
    let layer = [];
    layers.push( layer );
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( layer ),
      visitedContainer : visited2,
      revisiting : 0,
    });
  }

  /* */

  return layers;

  /* */

  function handleUp1( node, it )
  {
    if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
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
      _.assert( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ), () => 'Input set of nodes does not have a node ' + group.nodeToName( node ) );
      layer.push( node );
    }
  }

}

//

function nodesStronglyConnectedTreeDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let visited1 = [];
  let visited2 = group.containerMake();
  let fromOriginal = new HashMap();

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAs( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.forEach( ( node ) =>
  {
    if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
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

  let group2 = sys.nodesGroup
  ({
    onNodeNameGet : group.nodeNameFromGetterId,
    onOutNodesGet : group.nodesFromFieldOutNodes,
    onInNodesGet : group.nodesFromFieldInNodes,
  });

  /* collect layers */

  group.reverse();

  for( let i = visited1.length-1 ; i >= 0 ; i-- )
  {
    let node = visited1[ i ];
    if( _.arrayHas( visited2, node, group.onNodeEvaluate || undefined ) )
    continue;
    let dnode = dnodeMake();
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( dnode ),
      visitedContainer : visited2,
      revisiting : 0,
    });
  }

  /* add edges */

  for( let l = 0 ; l < group2.nodes.length ; l++ )
  {
    let dnode = group2.nodes[ l ];
    for( let t = 0 ; t < dnode.originalOutNodes.length ; t++ )
    {
      let originalOutId = dnode.originalOutNodes[ t ];
      if( _.arrayHas( dnode.originalNodes, originalOutId ) )
      continue;
      let dnode2 = fromOriginal.get( originalOutId );
      _.arrayAppendOnce( dnode.outNodes, dnode2 );
      _.arrayAppendOnce( dnode2.inNodes, dnode );
    }
  }

  /* */

  return group2;

  /* */

  function dnodeMake()
  {
    let dnode = Object.create( null );
    dnode.inNodes = []; // xxx : use sets
    dnode.outNodes = [];
    dnode.originalNodes = [];
    dnode.originalOutNodes = [];
    group2.nodeAdd( dnode );
    return dnode;
  }

  /* */

  function handleUp1( node, it )
  {
    if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
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
    _.assert( _.arrayHas( nodes, node ), `Expects container with all nodes, but ${group.nodeToQualifiedName( node )} is not in the container` );
  }

  /* */

  function handleUp2_functor( dnode )
  {
    return function handleUp2( node, it )
    {
      _.assert( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ), () => 'Input set of nodes does not have a node ' + group.nodeToName( node ) );
      fromOriginal.set( it.node, dnode );
      dnode.originalNodes.push( node );
      _.arrayAppendArray( dnode.originalOutNodes, group.nodeOutNodesFor( node ) );
    }
  }

}

// --
// etc
// --

function nodeNameFromGetterId( nodeHandle )
{
  let group = this;
  return group.nodeToId( nodeHandle );
}

//

function nodeNameFromFieldName( nodeHandle )
{
  let group = this;
  return nodeHandle.name;
}

//

function nodeIs_default( nodeHandle )
{
  if( nodeHandle === null || nodeHandle === undefined )
  return false;
  return _.maybe;
}

//

function inNodesFromGroupCache( nodeHandle )
{
  let group = this;
  let outNodes = group._inNodesCacheHash.get( nodeHandle );
  _.assert( _.arrayIs( outNodes ), 'No cache for the node' );
  return outNodes;
}

//

function nodesFromFieldNodes( nodeHandle )
{
  let group = this;
  return nodeHandle.nodes;
}

//

function nodesFromFieldOutNodes( nodeHandle )
{
  let group = this;
  return nodeHandle.outNodes;
}

//

function nodesFromFieldInNodes( nodeHandle )
{
  let group = this;
  return nodeHandle.inNodes;
}

//

function nodesFromIdsFromFieldNodes( nodeHandle )
{
  let group = this;
  return group.idsToNodes( nodeHandle.nodes );
}

//

function nodesFromIdsFromFieldOutNodes( nodeHandle )
{
  let group = this;
  return group.idsToNodes( nodeHandle.outNodes );
}

//

function nodesFromIdsFromFieldInNodes( nodeHandle )
{
  let group = this;
  return group.idsToNodes( nodeHandle.inNodes );
}

//

function nodesIdsFromNodesFromFieldNodes( nodeHandle )
{
  let group = this;
  return group.nodesToIds( nodeHandle.nodes );
}

//

function nodesIdsFromNodesFromFieldOutNodes( nodeHandle )
{
  let group = this;
  return group.nodesToIds( nodeHandle.outNodes );
}

//

function nodesIdsFromNodesFromFieldInNodes( nodeHandle )
{
  let group = this;
  return group.nodesToIds( nodeHandle.inNodes );
}

//

function nodesIdsFromFieldNodes( nodeHandle )
{
  let group = this;
  return nodeHandle.nodes;
}

//

function nodesIdsFromFieldOutNodes( nodeHandle )
{
  let group = this;
  return nodeHandle.outNodes;
}

//

function nodesIdsFromFieldInNodes( nodeHandle )
{
  let group = this;
  return nodeHandle.inNodes;
}

// --
// special classes
// --

class ContainerWrap
{
}

class SetWrap extends ContainerWrap
{
  container = null;
  constructor( container )
  {
    super();
    _.assert( arguments.length === 1 );
    _.assert( _.setIs( container ) );
    this.container = container;
  }
  has( e )
  {
    return this.container.has( e );
  }
  push( e )
  {
    this.container.add( e );
    return this.container.size;
  }
  pop( e )
  {
    debugger;
    _.assert( arguments.length === 1 );
    let r = this.container.delete( e );
    return e;
  }
  removedOnce( e )
  {
    debugger;
    return this.container.delete( e );
  }
  all( onEach )
  {
    for( let e of this.container )
    {
      let r = onEach( e, undefined, this.container );
      if( !r )
      return r;
    }
    return true;
  }
  any( onEach )
  {
    for( let e of this.container )
    {
      let r = onEach( e, undefined, this.container );
      if( r )
      return r;
    }
    return false;
  }
  none( onEach )
  {
    for( let e of this.container )
    {
      let r = onEach( e, undefined, this.container );
      if( r )
      return false;
    }
    return true;
  }
}

//

class ArrayWrap extends ContainerWrap
{
  container = null;
  constructor( container )
  {
    super();
    _.assert( arguments.length === 1 );
    _.assert( _.arrayIs( container ) );
    this.container = container;
  }
  has( e )
  {
    return this.container.includes( e );
  }
  push( e )
  {
    return this.container.push( e );
  }
  pop( e )
  {
    debugger;
    var poped = this.container.pop();
    _.assert( e === undefined || poped === e );
    return poped;
  }
  removedOnce( e )
  {
    debugger;
    return _.arrayRemovedOnce( e );
  }
  all( onEach )
  {
    return this.container.every( onEach );
  }
  any( onEach )
  {
    return this.container.some( onEach );
  }
  none( onEach )
  {
    return !this.container.some( onEach );
  }
}

// --
// relations
// --

let nodesSymbol = Symbol.for( 'nodes' );
let directSymbol = Symbol.for( 'direct' );

let Composes =
{
  direct : true,
}

let Aggregates =
{
  onNodeNameGet : nodeNameFromGetterId,
  onNodeQualifiedNameGet : null,
  onNodeEvaluate : null, /* qqq : cover by tests with different routines */
  onNodeIs : nodeIs_default,
  onOutNodesGet : nodesFromFieldNodes,
  onInNodesGet : null,
  onNodeInfoExport : null,
  onNodeIdGet : null,
}

let Associates =
{
  sys : null,
  nodes : _.define.own([]),
}

let Restricts =
{
  _inNodesCacheHash : null,
}

let Statics =
{
  ContainerWrap,
  SetWrap,
  ArrayWrap,
}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
}

let Accessors =
{
  nodes : {},
  direct : {},
}

// --
// declare
// --

let Extend =
{

  init,
  finit,
  form,
  unform,
  clone,

  // reverse

  directSet,
  reverse,
  cacheInNodesFromOutNodesOnce,
  cacheInNodesFromOutNodesUpdate,
  cachesInvalidate,

  // export

  optionsExport,
  structureExport,
  infoExport,

  // descriptor

  nodeDescriptorWithId,
  nodeDescriptorWith,
  nodeDescriptorObtain,
  nodeDescriptorDelete,

  // nodeHandle

  nodeHas,
  nodesHas : _.vectorize( nodeHas ),
  nodesHasAll : _.vectorizeAll( nodeHas ),
  nodesHasAny : _.vectorizeAny( nodeHas ),
  nodesHasNone : _.vectorizeNone( nodeHas ),

  nodeIs,
  nodesAre : _.vectorize( nodeIs ),
  nodesAreAll : _.vectorizeAll( nodeIs ),
  nodesAreAny : _.vectorizeAny( nodeIs ),
  nodesAreNone : _.vectorizeNone( nodeIs ),

  nodeIndegree,
  nodesIndegree : _.vectorize( nodeIndegree ),
  nodeOutdegree,
  nodesOutdegree : _.vectorize( nodeOutdegree ),
  nodeDegree,
  nodesDegree : _.vectorize( nodeDegree ),
  nodeOutNodesFor,
  nodesOutNodesFor : _.vectorize( nodeOutNodesFor ),
  nodeInNodesFor,
  nodesInNodesFor : _.vectorize( nodeInNodesFor ),
  nodeOutNodesIdsFor,
  nodesOutNodesIdsFor : _.vectorize( nodeOutNodesIdsFor ),
  nodeInNodesIdsFor,
  nodesInNodesIdsFor : _.vectorize( nodeInNodesIdsFor ),
  nodeRefNumber,
  nodesSet,

  nodeAdd,
  nodesAdd : _.vectorize( nodeAdd ),
  nodeDelete,
  nodesDelete,

  nodeDataExport,
  nodesDataExport : _.vectorize( nodeDataExport ),
  nodeInfoExport,
  nodesInfoExport,
  nodesExportInfoTree,


  nodeToQualifiedName,
  nodesToQualifiedNames : _.vectorize( nodeToQualifiedName ),
  nodeToName,
  nodesToNames : _.vectorize( nodeToName ),
  nodeToNameTry,
  nodesToNamesTry : _.vectorize( nodeToNameTry ),
  nodeToIdTry,
  nodesToIdsTry : _.vectorize( nodeToIdTry ),
  nodeToId,
  nodesToIds : _.vectorize( nodeToId ),
  idToNodeTry,
  idsToNodesTry : _.vectorize( idToNodeTry ),
  idToNode,
  idsToNodes : _.vectorize( idToNode ),
  idToName,
  idsToNames : _.vectorize( idToName ),

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

  rootsAllReachable,
  nodesAs,
  containerIs,
  containerMake,
  containerAdapter,

  // traverser

  lookBfs,
  lookDfs,
  lookDbfs,
  look : lookDfs,

  each,
  eachBfs,
  eachDfs,
  eachDbfs,

  // orderer

  dagTopSortDfs,
  dagTopSort : dagTopSortDfs,
  topSortSourceBasedBfs,
  topSortSourceBased : topSortSourceBasedBfs,
  topSortCycledSourceBasedBfs,
  topSortCycledSourceBased : topSortCycledSourceBasedBfs,

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
  nodesStronglyConnectedTreeDfs,
  nodesStronglyConnectedTree : nodesStronglyConnectedTreeDfs,

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
