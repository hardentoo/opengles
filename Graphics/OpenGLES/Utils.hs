module Graphics.OpenGLES.Utils where
--import Data.Array.ST (newArray, getElems, MArray, STUArray)
--import Data.Array.Unsafe (castSTUArray)
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BS
import Data.Vect
--import Data.Word (Word8)
--import GHC.ST (runST, ST)
import Graphics.OpenGLES.Base
import Graphics.OpenGLES.Core (Program(..), Shader(..))


structMat2 :: [Float] -> Mat2
structMat2 [a,b,c,d] = Mat2 (Vec2 a b) (Vec2 c d)
structMat2 xs = error $ "structMat2: not a 2x2 matrix: " ++ show xs

structMat3 :: [Float] -> Mat3
structMat3 [a,b,c,d,e,f,g,h,i] = Mat3 (Vec3 a b c) (Vec3 d e f)(Vec3 g h i)
structMat3 xs = error $ "structMat3: not a 3x3 matrix: " ++ show xs

structMat4 :: [Float] -> Mat4
structMat4 [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p] =
	Mat4 (Vec4 a b c d) (Vec4 e f g h) (Vec4 i j k l) (Vec4 m n o p)
structMat4 xs = error $ "structMat4: not a 4x4 matrix: " ++ show xs

orthoMatrix :: (Float,Float) -- ^ (left,right)
            -> (Float,Float) -- ^ (bottom,top)
            -> (Float,Float) -- ^ (near,far)
            -> Mat4
orthoMatrix (l,r) (b,t) (n,f) = Mat4
	(Vec4 (2/(r-l)) 0 0 0)
	(Vec4 0 (2/(t-b)) 0 0)
	(Vec4 0 0 (-2/(f-n)) 0)
	(Vec4 (-(r+l)/(r-l)) (-(t+b)/(t-b)) (-(f+n)/(f-n)) 1)

-- | The same as "orthoMatrix", but with a different parametrization.
orthoMatrix' :: Vec3 -- ^ (left,top,near)
             -> Vec3 -- ^ (right,bottom,far)
             -> Mat4
orthoMatrix' (Vec3 l t n) (Vec3 r b f) = orthoMatrix (l,r) (b,t) (n,f)

-- | \"Perspective projecton\" matrix
frustumMatrix :: (Float,Float) -- ^ (left,right)
              -> (Float,Float) -- ^ (bottom,top)
              -> (Float,Float) -- ^ (near,far)
              -> Mat4
frustumMatrix (l,r) (b,t) (n,f) = Mat4
	(Vec4 (2*n/(r-l)) 0 0 0)
	(Vec4 0 (2*n/(t-b)) 0 0)
	(Vec4 ((r+l)/(r-l)) ((t+b)/(t-b)) (-(f+n)/(f-n)) (-1))
	(Vec4 0 0 (-2*f*n/(f-n)) 0)
  
-- | The same as "frustumMatrix", but with a different parametrization.
frustumMatrix' :: Vec3 -- ^ (left,top,near)
               -> Vec3 -- ^ (right,bottom,far)
               -> Mat4 
frustumMatrix' (Vec3 l t n) (Vec3 r b f) = frustumMatrix (l,r) (b,t) (n,f)

-- | Inverse of "frustumMatrix"
inverseFrustumMatrix :: (Float,Float) -- ^ (left,right)
                     -> (Float,Float) -- ^ (bottom,top)
                     -> (Float,Float) -- ^ (near,far)
                     -> Mat4
inverseFrustumMatrix (l,r) (b,t) (n,f) = Mat4
	(Vec4 (0.5*(r-l)/n) 0 0 0)
	(Vec4 0 (0.5*(t-b)/n) 0 0)
	(Vec4 0 0 0 (0.5*(n-f)/(f*n)))
	(Vec4 (0.5*(r+l)/n) (0.5*(t+b)/n) (-1) (0.5*(f+n)/(f*n)))


{-
data BufferMarkup = BufferMarkup [String] [String]

packToBlob :: BufferMarkup -> Blob
packToBlob (BufferMarkup types values) =
	Blob $ B.concat $ zipWith toBS (cycle types) values

toBS :: String -> String -> B.ByteString
toBS "float" v = B.pack $ cast (read v)
toBS "hex" v = B.pack $ map (read.("0x"++)) (chunkOf v)

chunkOf [] = []
chunkOf (a:b:xs) = [a, b] : chunkOf xs

{-# INLINE cast #-}
cast :: Float -> [Word8]
cast x = runST (newArray (0 :: Int, 3) x >>= castSTUArray >>= getElems)

packedBlob = packToBlob vertexColors

vertexColors = BufferMarkup
	["float", "float", "hex"]
	["-0.7", "-0.7", "00FF00"
	, "0.7", "-0.7", "0000FF"
	,"-0.7",  "0.7", "FF0000"
	, "0.7",  "0.7", "00FFFF"
	]
-}

pureProgram = Program "Graphics.OpenGLES.Utils.pureProgram"
	[ VertexShader "pureVertexShader" pureVertexShader
	, FragmentShader "pureFragmentShader" pureFragmentShader
	]

-- deprecated
pureVertexShader = BS.pack $
	--"#version 100\n" ++
	"attribute vec4 pos;\n" ++
	"attribute vec4 color;\n" ++
	"varying vec4 vColor;\n" ++
	"void main() {\n" ++
	"    gl_Position = pos;\n" ++
	"    vColor = color;\n" ++
	"}\n"
-- deprecated
pureFragmentShader = BS.pack $
	"#version 100\n" ++
	"precision mediump float;\n" ++
	"varying vec4 vColor;\n" ++
	"void main() {\n" ++
	"    gl_FragColor = vColor;\n" ++
	"}\n"

-- sequence [($ cos (x/100)) | x <- [0..100]] (\x -> Vec3 0 x 0)
-- [Vec2 x $ sin (x/50) | x <- [0..100]]

circle2d n | n > 1 = [Vec2 (cos t) (sin t) | t <- [0,2*pi/n..2*pi]]

rect x y w h = [Vec2 x y, Vec2 (x+w) y, Vec2 (x+w) (y+h), Vec2 x (y+h)]

yEqual f from to = [Vec2 x (f x) | x <- [from..to]]

xEqual g from to = [Vec2 (g y) y | y <- [from..to]]

{-
enable :: Capability -> IO ()
enable = glEnable . marshal

disable :: Capability -> IO ()
disable = glDisable . marshal

isEnabled :: Capability -> IO Bool
isEnabled = liftA (/= 0) . glIsEnabled . marshal

-- | glClear
clearBuffer :: Bool -- ^ Clear color buffer
            -> Bool -- ^ Clear depth buffer
            -> Bool -- ^ Clear stencil buffer
            -> IO ()
clearBuffer c d s = glClear $ (if d then 0x100 else 0)
  .|. (if s then 0x400 else 0) .|. (if c then 0x4000 else 0)

getGLVendor = glGetString 0x1F00 >>= peekCString
getGLRenderer = glGetString 0x1F01 >>= peekCString
getGLVersion = glGetString 0x1F02 >>= peekCString
getGLExtensions = words <$> (glGetString 0x1F03 >>= peekCString)
getGLShadingLanguageVersion = glGetString 0x8B8C >>= peekCString
-}

viewport :: (Integral a, Integral b) => a -> a -> b -> b -> IO ()
viewport x y w h = glViewport (fromIntegral x) (fromIntegral y)
                              (fromIntegral w) (fromIntegral h)

flashCommands :: IO ()
flashCommands = glFlush

waitForFinish :: IO ()
waitForFinish = glFinish

data SyncResult = AlreadySignaled
                | ConditionSatisfied
                | TimeoutExpired
                | WaitFailed 
                | InvalidValue_

-- | better glFinish for ES 3.0
waitForGPUCommandsComplete :: (Integral a)
                           => Bool -- ^ flag for GL_SYNC_FLUSH_COMMANDS_BIT
                           -> a -- ^ timeout in nanosecond
                           -> IO SyncResult
waitForGPUCommandsComplete flashCmds timeout_ns = do
	sync <- glFenceSync 0x9117 0 -- GL_SYNC_GPU_COMMANDS_COMPLETE
	res <- glClientWaitSync sync (if flashCmds then 1 else 0)
			(fromIntegral timeout_ns)
	glDeleteSync sync
	return $ case res of
		0x911A -> AlreadySignaled -- GL_ALREADY_SIGNALED
		0x911C -> ConditionSatisfied -- GL_CONDITION_SATISFIED
		0x911B -> TimeoutExpired -- GL_TIMEOUT_EXPIRED
		0x911D -> WaitFailed -- GL_WAIT_FAILED
		0x0501 -> InvalidValue_ -- GL_INVALID_VALUE

-- | ES 3.0
blockGPUWhileDraw :: IO ()
blockGPUWhileDraw = do
	sync <- glFenceSync 0x9117 0 -- GL_SYNC_GPU_COMMANDS_COMPLETE
	glWaitSync sync 0 0xFFFFFFFFFFFFFFFF -- GL_TIMEOUT_IGNORED
	glDeleteSync sync

--unsafeDrawData :: DrawCall -> IO ()
--unsafeDrawData dc = compileCall >>= drawData
