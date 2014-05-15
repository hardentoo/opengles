{-# LANGUAGE CPP #-}
-- | OpenGL ES (ES for Embed Systems) 2.0
-- <http://www.khronos.org/opengles/sdk/docs/reference_cards/OpenGL-ES-2_0-Reference-card.pdf>
-- <http://www.khronos.org/files/opengles3-quick-reference-card.pdf>
-- 
-- ANGLE: OpenGL ES 2.0 backend for Windows.
-- http://code.google.com/p/angleproject/

module Graphics.OpenGLES where
import Control.Applicative
import Data.Bits
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal.Alloc (alloca)
import Foreign.Marshal.Array
import Foreign.Ptr
import Foreign.Storable
import Graphics.EGL (eglGetProcAddress)
import Graphics.OpenGLES.Types

isGLProcAvailable :: String -> Bool
isGLProcAvailable name = eglGetProcAddress name /= nullFunPtr

--getopenglversion, dummy call or throwifnull

#define GL_PROC(_procname, _typ) \
foreign import ccall unsafe "dynamic" unwrap_/**/_procname :: FunPtr (_typ) -> _typ; \
_procname :: _typ; \
_procname = unwrap_/**/_procname (eglGetProcAddress "_procname"); 

-- foreign import ccall unsafe "dynamic"
--   unwrap_glActiveTexture :: FunPtr (GLenum -> IO ()) -> GLenum -> IO ();
-- glActiveTexture :: GLenum -> IO ();
-- glActiveTexture = unwrap_glActiveTexture (eglGetProcAddress "glActiveTexture");

-- * OpenGL ES 2.0

GL_PROC(glActiveTexture, GLenum -> IO ())
GL_PROC(glAttachShader, GLuint -> GLuint -> IO ())
GL_PROC(glBindAttribLocation, GLuint -> GLuint -> CString -> IO ())
GL_PROC(glBindBuffer, GLenum -> GLuint -> IO ())
GL_PROC(glBindFramebuffer, GLenum -> GLuint -> IO ())
GL_PROC(glBindRenderbuffer, GLenum -> GLuint -> IO ())
GL_PROC(glBindTexture, GLenum -> GLuint -> IO ())
GL_PROC(glBlendColor, GLclampf -> GLclampf -> GLclampf -> GLclampf -> IO ())
GL_PROC(glBlendEquation, GLenum -> IO ())
GL_PROC(glBlendEquationSeparate, GLenum -> GLenum -> IO ())
GL_PROC(glBlendFunc, GLenum -> GLenum -> IO ())
GL_PROC(glBlendFuncSeparate, GLenum -> GLenum -> GLenum -> GLenum -> IO ())
GL_PROC(glBufferData, GLenum -> GLsizeiptr -> Ptr () -> GLenum -> IO ())
GL_PROC(glBufferSubData, GLenum -> GLintptr -> GLsizeiptr -> Ptr () -> IO ())
GL_PROC(glCheckFramebufferStatus, GLenum -> IO GLenum)
GL_PROC(glClear, GLbitfield -> IO ())
GL_PROC(glClearColor, GLclampf -> GLclampf -> GLclampf -> GLclampf -> IO ())
GL_PROC(glClearDepthf, GLclampf -> IO ())
GL_PROC(glClearStencil, GLint -> IO ())
GL_PROC(glColorMask, GLboolean -> GLboolean -> GLboolean -> GLboolean -> IO ())
GL_PROC(glCompileShader, GLuint -> IO ())
GL_PROC(glCompressedTexImage2D, GLenum -> GLint -> GLenum -> GLsizei -> GLsizei -> GLint -> GLsizei -> Ptr () -> IO ())
GL_PROC(glCompressedTexSubImage2D, GLenum -> GLint -> GLint -> GLint -> GLsizei -> GLsizei -> GLenum -> GLsizei -> Ptr () -> IO ())
GL_PROC(glCopyTexImage2D, GLenum -> GLint -> GLenum -> GLint -> GLint -> GLsizei -> GLsizei -> GLint -> IO ())
GL_PROC(glCopyTexSubImage2D, GLenum -> GLint -> GLint -> GLint -> GLint -> GLint -> GLsizei -> GLsizei -> IO ())
GL_PROC(glCreateProgram, IO GLuint)
GL_PROC(glCreateShader, GLenum -> IO GLuint)
GL_PROC(glCullFace, GLenum -> IO ())
GL_PROC(glDeleteBuffers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glDeleteFramebuffers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glDeleteProgram, GLuint -> IO ())
GL_PROC(glDeleteRenderbuffers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glDeleteShader, GLuint -> IO ())
GL_PROC(glDeleteTextures, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glDepthFunc, GLenum -> IO ())
GL_PROC(glDepthMask, GLboolean -> IO ())
GL_PROC(glDepthRangef, GLclampf -> GLclampf -> IO ())
GL_PROC(glDetachShader, GLuint -> GLuint -> IO ())
GL_PROC(glDisable, GLenum -> IO ())
GL_PROC(glDisableVertexAttribArray, GLuint -> IO ())
GL_PROC(glDrawArrays, GLenum -> GLint -> GLsizei -> IO ())
GL_PROC(glDrawElements, GLenum -> GLsizei -> GLenum -> Ptr () -> IO ())
GL_PROC(glEnable, GLenum -> IO ())
GL_PROC(glEnableVertexAttribArray, GLuint -> IO ())
GL_PROC(glFinish, IO ())
GL_PROC(glFlush, IO ())
GL_PROC(glFramebufferRenderbuffer, GLenum -> GLenum -> GLenum -> GLuint -> IO ())
GL_PROC(glFramebufferTexture2D, GLenum -> GLenum -> GLenum -> GLuint -> GLint -> IO ())
GL_PROC(glFrontFace, GLenum -> IO ())
GL_PROC(glGenBuffers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGenerateMipmap, GLenum -> IO ())
GL_PROC(glGenFramebuffers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGenRenderbuffers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGenTextures, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGetActiveAttrib, GLuint -> GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLint -> Ptr GLenum -> Ptr GLchar -> IO ())
GL_PROC(glGetActiveUniform, GLuint -> GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLint -> Ptr GLenum -> Ptr GLchar -> IO ())
GL_PROC(glGetAttachedShaders, GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGetAttribLocation, GLuint -> CString -> IO GLint)
GL_PROC(glGetBooleanv, GLenum -> Ptr GLboolean -> IO ())
GL_PROC(glGetBufferParameteriv, GLenum -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetError, IO GLenum)
GL_PROC(glGetFloatv, GLenum -> Ptr GLfloat -> IO ())
GL_PROC(glGetFramebufferAttachmentParameteriv, GLenum -> GLenum -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetIntegerv, GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetProgramiv, GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetProgramInfoLog, GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLchar -> IO ())
GL_PROC(glGetRenderbufferParameteriv, GLenum -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetShaderiv, GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetShaderInfoLog, GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLchar -> IO ())
GL_PROC(glGetShaderPrecisionFormat, GLenum -> GLenum -> Ptr GLint -> Ptr GLint -> IO ())
GL_PROC(glGetShaderSource, GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLchar -> IO ())
GL_PROC(glGetString, GLenum -> IO CString)
GL_PROC(glGetTexParameterfv, GLenum -> GLenum -> Ptr GLfloat -> IO ())
GL_PROC(glGetTexParameteriv, GLenum -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetUniformfv, GLuint -> GLint -> Ptr GLfloat -> IO ())
GL_PROC(glGetUniformiv, GLuint -> GLint -> Ptr GLint -> IO ())
GL_PROC(glGetUniformLocation, GLuint -> CString -> IO GLint)
GL_PROC(glGetVertexAttribfv, GLuint -> GLenum -> Ptr GLfloat -> IO ())
GL_PROC(glGetVertexAttribiv, GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetVertexAttribPointerv, GLuint -> GLenum -> Ptr (Ptr ()) -> IO ())
GL_PROC(glHint, GLenum -> GLenum -> IO ())
GL_PROC(glIsBuffer, GLuint -> IO GLboolean)
GL_PROC(glIsEnabled, GLenum -> IO GLboolean)
GL_PROC(glIsFramebuffer, GLuint -> IO GLboolean)
GL_PROC(glIsProgram, GLuint -> IO GLboolean)
GL_PROC(glIsRenderbuffer, GLuint -> IO GLboolean)
GL_PROC(glIsShader, GLuint -> IO GLboolean)
GL_PROC(glIsTexture, GLuint -> IO GLboolean)
GL_PROC(glLineWidth, GLfloat -> IO ())
GL_PROC(glLinkProgram, GLuint -> IO ())
GL_PROC(glPixelStorei, GLenum -> GLint -> IO ())
GL_PROC(glPolygonOffset, GLfloat -> GLfloat -> IO ())
GL_PROC(glReadPixels, GLint -> GLint -> GLsizei -> GLsizei -> GLenum -> GLenum -> Ptr () -> IO ())
GL_PROC(glReleaseShaderCompiler, IO ())
GL_PROC(glRenderbufferStorage, GLenum -> GLenum -> GLsizei -> GLsizei -> IO ())
GL_PROC(glSampleCoverage, GLclampf -> GLboolean -> IO ())
GL_PROC(glScissor, GLint -> GLint -> GLsizei -> GLsizei -> IO ())
GL_PROC(glShaderBinary, GLsizei -> Ptr GLuint -> GLenum -> Ptr () -> GLsizei -> IO ())
GL_PROC(glShaderSource, GLuint -> GLsizei -> Ptr CString -> Ptr GLint -> IO ())
GL_PROC(glStencilFunc, GLenum -> GLint -> GLuint -> IO ())
GL_PROC(glStencilFuncSeparate, GLenum -> GLenum -> GLint -> GLuint -> IO ())
GL_PROC(glStencilMask, GLuint -> IO ())
GL_PROC(glStencilMaskSeparate, GLenum -> GLuint -> IO ())
GL_PROC(glStencilOp, GLenum -> GLenum -> GLenum -> IO ())
GL_PROC(glStencilOpSeparate, GLenum -> GLenum -> GLenum -> GLenum -> IO ())
GL_PROC(glTexImage2D, GLenum -> GLint -> GLint -> GLsizei -> GLsizei -> GLint -> GLenum -> GLenum -> Ptr () -> IO ())
GL_PROC(glTexParameterf, GLenum -> GLenum -> GLfloat -> IO ())
GL_PROC(glTexParameterfv, GLenum -> GLenum -> Ptr GLfloat -> IO ())
GL_PROC(glTexParameteri, GLenum -> GLenum -> GLint -> IO ())
GL_PROC(glTexParameteriv, GLenum -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glTexSubImage2D, GLenum -> GLint -> GLint -> GLint -> GLsizei -> GLsizei -> GLenum -> GLenum -> Ptr () -> IO ())
GL_PROC(glUniform1f, GLint -> GLfloat -> IO ())
GL_PROC(glUniform1fv, GLint -> GLsizei -> Ptr GLfloat -> IO ())
GL_PROC(glUniform1i, GLint -> GLint -> IO ())
GL_PROC(glUniform1iv, GLint -> GLsizei -> Ptr GLint -> IO ())
GL_PROC(glUniform2f, GLint -> GLfloat -> GLfloat -> IO ())
GL_PROC(glUniform2fv, GLint -> GLsizei -> Ptr GLfloat -> IO ())
GL_PROC(glUniform2i, GLint -> GLint -> GLint -> IO ())
GL_PROC(glUniform2iv, GLint -> GLsizei -> Ptr GLint -> IO ())
GL_PROC(glUniform3f, GLint -> GLfloat -> GLfloat -> GLfloat -> IO ())
GL_PROC(glUniform3fv, GLint -> GLsizei -> Ptr GLfloat -> IO ())
GL_PROC(glUniform3i, GLint -> GLint -> GLint -> GLint -> IO ())
GL_PROC(glUniform3iv, GLint -> GLsizei -> Ptr GLint -> IO ())
GL_PROC(glUniform4f, GLint -> GLfloat -> GLfloat -> GLfloat -> GLfloat -> IO ())
GL_PROC(glUniform4fv, GLint -> GLsizei -> Ptr GLfloat -> IO ())
GL_PROC(glUniform4i, GLint -> GLint -> GLint -> GLint -> GLint -> IO ())
GL_PROC(glUniform4iv, GLint -> GLsizei -> Ptr GLint -> IO ())
GL_PROC(glUniformMatrix2fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix3fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix4fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUseProgram, GLuint -> IO ())
GL_PROC(glValidateProgram, GLuint -> IO ())
GL_PROC(glVertexAttrib1f, GLuint -> GLfloat -> IO ())
GL_PROC(glVertexAttrib1fv, GLuint -> Ptr GLfloat -> IO ())
GL_PROC(glVertexAttrib2f, GLuint -> GLfloat -> GLfloat -> IO ())
GL_PROC(glVertexAttrib2fv, GLuint -> Ptr GLfloat -> IO ())
GL_PROC(glVertexAttrib3f, GLuint -> GLfloat -> GLfloat -> GLfloat -> IO ())
GL_PROC(glVertexAttrib3fv, GLuint -> Ptr GLfloat -> IO ())
GL_PROC(glVertexAttrib4f, GLuint -> GLfloat -> GLfloat -> GLfloat -> GLfloat -> IO ())
GL_PROC(glVertexAttrib4fv, GLuint -> Ptr GLfloat -> IO ())
GL_PROC(glVertexAttribPointer, GLuint -> GLint -> GLenum -> GLboolean -> GLsizei -> Ptr () -> IO ())
GL_PROC(glViewport, GLint -> GLint -> GLsizei -> GLsizei -> IO ())

-- * OpenGL ES 3.0

GL_PROC(glReadBuffer, GLenum -> IO ())
GL_PROC(glDrawRangeElements, GLenum -> GLuint -> GLuint -> GLsizei -> GLenum -> Ptr (()) -> IO ())
GL_PROC(glTexImage3D, GLenum -> GLint -> GLint -> GLsizei -> GLsizei -> GLsizei -> GLint -> GLenum -> GLenum -> Ptr (()) -> IO ())
GL_PROC(glTexSubImage3D, GLenum -> GLint -> GLint -> GLint -> GLint -> GLsizei -> GLsizei -> GLsizei -> GLenum -> GLenum -> Ptr () -> IO ())
GL_PROC(glCopyTexSubImage3D, GLenum -> GLint -> GLint -> GLint -> GLint -> GLint -> GLint -> GLsizei -> GLsizei -> IO ())
GL_PROC(glCompressedTexImage3D, GLenum -> GLint -> GLenum -> GLsizei -> GLsizei -> GLsizei -> GLint -> GLsizei -> Ptr () -> IO ())
GL_PROC(glCompressedTexSubImage3D, GLenum -> GLint -> GLint -> GLint -> GLint -> GLsizei -> GLsizei -> GLsizei -> GLenum -> GLsizei -> Ptr () -> IO ())
GL_PROC(glGenQueries, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glDeleteQueries, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glIsQuery, GLuint -> IO GLboolean)
GL_PROC(glBeginQuery, GLenum -> GLuint -> IO ())
GL_PROC(glEndQuery, GLenum -> IO ())
GL_PROC(glGetQueryiv, GLenum -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetQueryObjectuiv, GLuint -> GLenum -> Ptr GLuint -> IO ())
GL_PROC(glUnmapBuffer, GLenum -> IO GLboolean)
GL_PROC(glGetBufferPointerv, GLenum -> GLenum -> Ptr (Ptr ()) -> IO ())
GL_PROC(glDrawBuffers, GLsizei -> Ptr GLenum -> IO ())
GL_PROC(glUniformMatrix2x3fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix3x2fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix2x4fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix4x2fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix3x4fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glUniformMatrix4x3fv, GLint -> GLsizei -> GLboolean -> Ptr GLfloat -> IO ())
GL_PROC(glBlitFramebuffer, GLint -> GLint -> GLint -> GLint -> GLint -> GLint -> GLint -> GLint -> GLbitfield -> GLenum -> IO ())
GL_PROC(glRenderbufferStorageMultisample, GLenum -> GLsizei -> GLenum -> GLsizei -> GLsizei -> IO ())
GL_PROC(glFramebufferTextureLayer, GLenum -> GLenum -> GLuint -> GLint -> GLint -> IO ())
GL_PROC(glMapBufferRange, GLenum -> GLintptr -> GLsizeiptr -> GLbitfield -> IO (Ptr ()))
GL_PROC(glFlushMappedBufferRange, GLenum -> GLintptr -> GLsizeiptr -> IO ())
GL_PROC(glBindVertexArray, GLuint -> IO ())
GL_PROC(glDeleteVertexArrays, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGenVertexArrays, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glIsVertexArray, GLuint -> IO GLboolean)
GL_PROC(glGetIntegeri_v, GLenum -> GLuint -> Ptr GLint -> IO ())
GL_PROC(glBeginTransformFeedback, GLenum -> IO ())
GL_PROC(glEndTransformFeedback, IO ())
GL_PROC(glBindBufferRange, GLenum -> GLuint -> GLuint -> GLintptr -> GLsizeiptr -> IO ())
GL_PROC(glBindBufferBase, GLenum -> GLuint -> GLuint -> IO ())
--GL_PROC(glTransformFeedbackVaryings, GLuint -> GLsizei -> Ptr GLchar Ptr const -> GLenum -> IO ())
GL_PROC(glGetTransformFeedbackVarying, GLuint -> GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLsizei -> Ptr GLenum -> Ptr GLchar -> IO ())
GL_PROC(glVertexAttribIPointer, GLuint -> GLint -> GLenum -> GLsizei -> Ptr () -> IO ())
GL_PROC(glGetVertexAttribIiv, GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetVertexAttribIuiv, GLuint -> GLenum -> Ptr GLuint -> IO ())
GL_PROC(glVertexAttribI4i, GLuint -> GLint -> GLint -> GLint -> GLint -> IO ())
GL_PROC(glVertexAttribI4ui, GLuint -> GLuint -> GLuint -> GLuint -> GLuint -> IO ())
GL_PROC(glVertexAttribI4iv, GLuint -> Ptr GLint -> IO ())
GL_PROC(glVertexAttribI4uiv, GLuint -> Ptr GLuint -> IO ())
GL_PROC(glGetUniformuiv, GLuint -> GLint -> Ptr GLuint -> IO ())
GL_PROC(glGetFragDataLocation, GLuint -> CString-> IO GLint)
GL_PROC(glUniform1ui, GLint -> GLuint -> IO ())
GL_PROC(glUniform2ui, GLint -> GLuint -> GLuint -> IO ())
GL_PROC(glUniform3ui, GLint -> GLuint -> GLuint -> GLuint -> IO ())
GL_PROC(glUniform4ui, GLint -> GLuint -> GLuint -> GLuint -> GLuint -> IO ())
GL_PROC(glUniform1uiv, GLint -> GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glUniform2uiv, GLint -> GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glUniform3uiv, GLint -> GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glUniform4uiv, GLint -> GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glClearBufferiv, GLenum -> GLint -> Ptr GLint -> IO ())
GL_PROC(glClearBufferuiv, GLenum -> GLint -> Ptr GLuint -> IO ())
GL_PROC(glClearBufferfv, GLenum -> GLint -> Ptr GLfloat -> IO ())
GL_PROC(glClearBufferfi, GLenum -> GLint -> GLfloat -> GLint -> IO ())
GL_PROC(glGetStringi, GLenum -> GLuint -> IO CString)
GL_PROC(glCopyBufferSubData, GLenum -> GLenum -> GLintptr -> GLintptr -> GLsizeiptr -> IO ())
--GL_PROC(glGetUniformIndices, GLuint -> GLsizei -> Ptr GLchar Ptr const -> Ptr GLuint -> IO ())
GL_PROC(glGetActiveUniformsiv, GLuint -> GLsizei -> Ptr GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetUniformBlockIndex, GLuint -> Ptr GLchar -> IO GLuint)
GL_PROC(glGetActiveUniformBlockiv, GLuint -> GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetActiveUniformBlockName, GLuint -> GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLchar -> IO ())
GL_PROC(glUniformBlockBinding, GLuint -> GLuint -> GLuint -> IO ())
GL_PROC(glDrawArraysInstanced, GLenum -> GLint -> GLsizei -> GLsizei -> IO ())
GL_PROC(glDrawElementsInstanced, GLenum -> GLsizei -> GLenum -> Ptr () -> GLsizei -> IO ())
GL_PROC(glFenceSync, GLenum -> GLbitfield -> IO ())
GL_PROC(glIsSync, GLsync -> IO GLsync)
GL_PROC(glDeleteSync, GLsync -> IO GLboolean)
GL_PROC(glClientWaitSync, GLsync -> GLbitfield -> GLuint64 -> IO GLenum)
GL_PROC(glWaitSync, GLsync -> GLbitfield -> GLuint64 -> IO ())
GL_PROC(glGetInteger64v, GLenum -> Ptr GLint64 -> IO ())
GL_PROC(glGetSynciv, GLsync -> GLenum -> GLsizei -> Ptr GLsizei -> Ptr GLint -> IO ())
GL_PROC(glGetInteger64i_v, GLenum -> GLuint -> Ptr GLint64 -> IO ())
GL_PROC(glGetBufferParameteri64v, GLenum -> GLenum -> Ptr GLint64 -> IO ())
GL_PROC(glGenSamplers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glDeleteSamplers, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glIsSampler, GLuint -> IO GLboolean)
GL_PROC(glBindSampler, GLuint -> GLuint -> IO ())
GL_PROC(glSamplerParameteri, GLuint -> GLenum -> GLint -> IO ())
GL_PROC(glSamplerParameteriv, GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glSamplerParameterf, GLuint -> GLenum -> GLfloat -> IO ())
GL_PROC(glSamplerParameterfv, GLuint -> GLenum -> Ptr GLfloat -> IO ())
GL_PROC(glGetSamplerParameteriv, GLuint -> GLenum -> Ptr GLint -> IO ())
GL_PROC(glGetSamplerParameterfv, GLuint -> GLenum -> Ptr GLfloat -> IO ())
GL_PROC(glVertexAttribDivisor, GLuint -> GLuint -> IO ())
GL_PROC(glBindTransformFeedback, GLenum -> GLuint -> IO ())
GL_PROC(glDeleteTransformFeedbacks, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glGenTransformFeedbacks, GLsizei -> Ptr GLuint -> IO ())
GL_PROC(glIsTransformFeedback, GLuint -> IO GLboolean)
GL_PROC(glPauseTransformFeedback, IO ())
GL_PROC(glResumeTransformFeedback, IO ())
GL_PROC(glGetProgramBinary, GLuint -> GLsizei -> Ptr GLsizei -> Ptr GLenum -> Ptr () -> IO ())
GL_PROC(glProgramBinary, GLuint -> GLenum -> Ptr () -> GLsizei -> IO ())
GL_PROC(glProgramParameteri, GLuint -> GLenum -> GLint -> IO ())
GL_PROC(glInvalidateFramebuffer, GLenum -> GLsizei -> Ptr GLenum -> IO ())
GL_PROC(glInvalidateSubFramebuffer, GLenum -> GLsizei -> Ptr GLenum -> GLint -> GLint -> GLsizei -> GLsizei -> IO ())
GL_PROC(glTexStorage2D, GLenum -> GLsizei -> GLenum -> GLsizei -> GLsizei -> IO ())
GL_PROC(glTexStorage3D, GLenum -> GLsizei -> GLenum -> GLsizei -> GLsizei -> GLsizei -> IO ())
GL_PROC(glGetInternalformativ, GLenum -> GLenum -> GLenum -> GLsizei -> Ptr GLint -> IO ())

-- | EnableCap
data OpenGLCapability =
	  Texture2D
	| CullFace
	| Blend
	| Dither
	| StencilTest
	| DepthTest
	| ScissorTest
	| PolygonOffsetFill
	| SampleAlphaToCoverage
	| SampleCoverage

instance Enum OpenGLCapability where
	fromEnum x = case x of
		Texture2D             -> 0x0DE1
		CullFace              -> 0x0B44
		Blend                 -> 0x0BE2
		Dither                -> 0x0BD0
		StencilTest           -> 0x0B90
		DepthTest             -> 0x0B71
		ScissorTest           -> 0x0C11
		PolygonOffsetFill     -> 0x8037
		SampleAlphaToCoverage -> 0x809E
		SampleCoverage        -> 0x80A0
	toEnum = undefined

enable :: OpenGLCapability -> IO ()
enable = glEnable . toGLEnum

disable :: OpenGLCapability -> IO ()
disable = glDisable . toGLEnum

isEnabled :: OpenGLCapability -> IO Bool
isEnabled = liftA (1 ==) . glIsEnabled . toGLEnum

toGLEnum :: (Enum a) => a -> GLenum
toGLEnum = fromIntegral . fromEnum

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

data CullFaceMode = Front | Back | FrontAndBack
instance Enum CullFaceMode where
	fromEnum Front        = 0x0404
	fromEnum Back         = 0x0405
	fromEnum FrontAndBack = 0x0408
	toEnum = undefined

stencilMaskSeparate :: CullFaceMode -> GLuint -> IO ()
stencilMaskSeparate face mask = glStencilMaskSeparate (toGLEnum face) mask

data HintTarget = GenerateMipmapHint
data HintMode = DontCare | Fastest | Nicest
instance Enum HintTarget where
	fromEnum GenerateMipmapHint = 0x8192
	toEnum = undefined
instance Enum HintMode where
	fromEnum DontCare = 0x1100
	fromEnum Fastest  = 0x1101
	fromEnum Nicest   = 0x1102
	toEnum = undefined

hint :: HintTarget -> HintMode -> IO ()
hint target hintmode = glHint (toGLEnum target) (toGLEnum hintmode) 

data StencilFunction =
	Never | Less | Equal | LEqual | Greater | NotEqual | GEqual | Always
instance Enum StencilFunction where
	fromEnum x = case x of
		Never    -> 0x0200
		Less     -> 0x0201
		Equal    -> 0x0202
		LEqual   -> 0x0203
		Greater  -> 0x0204
		NotEqual -> 0x0205
		GEqual   -> 0x0206
		Always   -> 0x0207
	toEnum = undefined

depthFunc :: StencilFunction -> IO ()
depthFunc = glDepthFunc . toGLEnum

data StencilOp =
	  StencilOpZero | StencilOpKeep | StencilOpReplace | StencilOpIncr
	| StencilOpDecr | StencilOpInvert | StencilOpIncrWrap | StencilOpDecrWrap
instance Enum StencilOp where
	fromEnum x = case x of
		StencilOpZero     -> 0x0000
		StencilOpKeep     -> 0x1E00
		StencilOpReplace  -> 0x1E01
		StencilOpIncr     -> 0x1E02
		StencilOpDecr     -> 0x1E03
		StencilOpInvert   -> 0x150A
		StencilOpIncrWrap -> 0x8507
		StencilOpDecrWrap -> 0x8508
	toEnum = undefined

stencilOp :: StencilOp -> StencilOp -> StencilOp -> IO ()
stencilOp sfail dpfail dppass =
	glStencilOp (toGLEnum sfail) (toGLEnum dpfail) (toGLEnum dppass)

stencilOpSeparate :: CullFaceMode -> StencilOp -> StencilOp -> StencilOp -> IO ()
stencilOpSeparate face sfail dpfail dppass =
	glStencilOpSeparate (toGLEnum face) (toGLEnum sfail)
	                    (toGLEnum dpfail) (toGLEnum dppass)

data FrontFaceDirection = CW | CCW
frontFace CW = glFrontFace 0x0900
frontFace CCW = glFrontFace 0x0901

cullFace :: CullFaceMode -> IO ()
cullFace = glCullFace . toGLEnum

data GLError = NoError | InvalidEnum | InvalidValue | InvalidOperation
             | OutOfMemory | InvalidFrameBufferOperation
instance Enum GLError where
	fromEnum = undefined
	toEnum x = case x of
		0x0000 -> NoError
		0x0500 -> InvalidEnum
		0x0501 -> InvalidValue
		0x0502 -> InvalidOperation
		0x0505 -> OutOfMemory
		0x0506 -> InvalidFrameBufferOperation

getError :: IO GLError
getError = toEnum . fromIntegral <$> glGetError



