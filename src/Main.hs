import Control.Concurrent
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString
import Data.ByteString.Char8

main :: IO ()
main = do
    sock <- socket AF_INET Stream 0
    bindSocket sock (SockAddrInet 8430 iNADDR_ANY)
    listen sock 2
    mainLoop sock

mainLoop :: Socket -> IO ()
mainLoop sock = do
    (client,_) <- accept sock
    forkIO $ do
        send client payload
        sClose client
    mainLoop sock


payload :: ByteString
payload = pack "<?xml version=\"1.0\"?>\
               \<!DOCTYPE cross-domain-policy SYSTEM \"/xml/dtds/cross-domain-policy.dtd\">\
               \<cross-domain-policy>\
               \    <site-control permitted-cross-domain-policies=\"master-only\"/>\
               \    <allow-access-from domain=\"*\" to-ports=\"6667\" />\
               \</cross-domain-policy>"
