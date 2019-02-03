( function _UseAbstractBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );

}

//

var _ = _global_.wTools;
var Parent = null;
var Self = _global_.wTools.graph = _global_.wTools.graph || Object.create( null );

//

})();
