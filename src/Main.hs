{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Control.Monad
import Text.Printf
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString
import Data.ByteString.Char8

main :: IO ()
main = do
    sock <- socket AF_INET Stream 0
    bindSocket sock (SockAddrInet 8430 iNADDR_ANY) -- 8430 is de-facto standard for flash policy daemons
    listen sock sOMAXCONN
    forever $ do
      (client,host) <- accept sock
      forkIO $ do
          printf "connection from %s\n" (show host)
          send client payload
          sClose client

payload :: ByteString
payload = pack "<?xml version=\"1.a\"?><!DOCTYPE cross-domain-policy SYSTEM \"/xml/dtds/cross-domain-policy.dtd\"><cross-domain-policy><site-control permitted-cross-domain-policies=\"master-only\"/><allow-access-from domain=\"*\" to-ports=\"6667\" /></cross-domain-policy>"
