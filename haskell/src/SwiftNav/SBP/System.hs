{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE TemplateHaskell             #-}
{-# LANGUAGE RecordWildCards             #-}

-- |
-- Module:      SwiftNav.SBP.System
-- Copyright:   Copyright (C) 2015 Swift Navigation, Inc.
-- License:     LGPL-3
-- Maintainer:  Mark Fine <dev@swiftnav.com>
-- Stability:   experimental
-- Portability: portable
--
-- Standardized system messages from Swift Navigation devices.

module SwiftNav.SBP.System
  ( module SwiftNav.SBP.System
  ) where

import BasicPrelude
import Control.Lens
import Control.Monad.Loops
import Data.Binary
import Data.Binary.Get
import Data.Binary.IEEE754
import Data.Binary.Put
import Data.ByteString.Lazy    hiding (ByteString)
import Data.Int
import Data.Word
import SwiftNav.SBP.TH
import SwiftNav.SBP.Types

{-# ANN module ("HLint: ignore Use camelCase"::String) #-}
{-# ANN module ("HLint: ignore Redundant do"::String) #-}
{-# ANN module ("HLint: ignore Use newtype instead of data"::String) #-}


msgStartup :: Word16
msgStartup = 0xFF00

-- | SBP class for message MSG_STARTUP (0xFF00).
--
-- The system start-up message is sent once on system start-up. It notifies the
-- host or other attached devices that the system has started and is now ready
-- to respond to commands or configuration requests.
data MsgStartup = MsgStartup
  { _msgStartup_cause      :: !Word8
    -- ^ Cause of startup
  , _msgStartup_startup_type :: !Word8
    -- ^ Startup type
  , _msgStartup_reserved   :: !Word16
    -- ^ Reserved
  } deriving ( Show, Read, Eq )

instance Binary MsgStartup where
  get = do
    _msgStartup_cause <- getWord8
    _msgStartup_startup_type <- getWord8
    _msgStartup_reserved <- getWord16le
    pure MsgStartup {..}

  put MsgStartup {..} = do
    putWord8 _msgStartup_cause
    putWord8 _msgStartup_startup_type
    putWord16le _msgStartup_reserved

$(makeSBP 'msgStartup ''MsgStartup)
$(makeJSON "_msgStartup_" ''MsgStartup)
$(makeLenses ''MsgStartup)

msgDgnssStatus :: Word16
msgDgnssStatus = 0xFF02

-- | SBP class for message MSG_DGNSS_STATUS (0xFF02).
--
-- This message provides information about the receipt of Differential
-- corrections.  It is expected to be sent with each receipt of a complete
-- corrections packet.
data MsgDgnssStatus = MsgDgnssStatus
  { _msgDgnssStatus_flags     :: !Word8
    -- ^ Status flags
  , _msgDgnssStatus_latency   :: !Word16
    -- ^ Latency of observation receipt
  , _msgDgnssStatus_num_signals :: !Word8
    -- ^ Number of signals from base station
  , _msgDgnssStatus_source    :: !Text
    -- ^ Corrections source string
  } deriving ( Show, Read, Eq )

instance Binary MsgDgnssStatus where
  get = do
    _msgDgnssStatus_flags <- getWord8
    _msgDgnssStatus_latency <- getWord16le
    _msgDgnssStatus_num_signals <- getWord8
    _msgDgnssStatus_source <- decodeUtf8 . toStrict <$> getRemainingLazyByteString
    pure MsgDgnssStatus {..}

  put MsgDgnssStatus {..} = do
    putWord8 _msgDgnssStatus_flags
    putWord16le _msgDgnssStatus_latency
    putWord8 _msgDgnssStatus_num_signals
    putByteString $ encodeUtf8 _msgDgnssStatus_source

$(makeSBP 'msgDgnssStatus ''MsgDgnssStatus)
$(makeJSON "_msgDgnssStatus_" ''MsgDgnssStatus)
$(makeLenses ''MsgDgnssStatus)

msgHeartbeat :: Word16
msgHeartbeat = 0xFFFF

-- | SBP class for message MSG_HEARTBEAT (0xFFFF).
--
-- The heartbeat message is sent periodically to inform the host or other
-- attached devices that the system is running. It is used to monitor system
-- malfunctions. It also contains status flags that indicate to the host the
-- status of the system and whether it is operating correctly. Currently, the
-- expected heartbeat interval is 1 sec.  The system error flag is used to
-- indicate that an error has occurred in the system. To determine the source
-- of the error, the remaining error flags should be inspected.
data MsgHeartbeat = MsgHeartbeat
  { _msgHeartbeat_flags :: !Word32
    -- ^ Status flags
  } deriving ( Show, Read, Eq )

instance Binary MsgHeartbeat where
  get = do
    _msgHeartbeat_flags <- getWord32le
    pure MsgHeartbeat {..}

  put MsgHeartbeat {..} = do
    putWord32le _msgHeartbeat_flags

$(makeSBP 'msgHeartbeat ''MsgHeartbeat)
$(makeJSON "_msgHeartbeat_" ''MsgHeartbeat)
$(makeLenses ''MsgHeartbeat)
