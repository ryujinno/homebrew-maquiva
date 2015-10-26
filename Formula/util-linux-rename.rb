require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'http://www.kernel.org/pub/linux/utils/util-linux/v2.27/util-linux-2.27.tar.gz'
  sha256   '21ede7eb6c3a2a9c7b13eeee241e82428be4f6d5030ff488f638817f419af093'

  depends_on :autoconf
  depends_on :automake

  def patches
    [ DATA ]
  end

  def install
    system 'autoreconf'
    system './configure', '--disable-dependency-tracking', "--prefix=#{prefix}"
    system 'make', 'rename' 
    bin.install 'rename'
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # 'false' with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test util-linux`.
    system 'false'
  end
end

#
# rename command does not use flock().
#

__END__
diff -urpN util-linux-2.27/configure.ac util-linux-2.27-no_use_flock/configure.ac
--- util-linux-2.27/configure.ac	2015-09-07 16:59:25.000000000 +0900
+++ util-linux-2.27-no_use_flock/configure.ac	2015-10-26 11:06:32.000000000 +0900
@@ -1382,7 +1382,7 @@ UL_REQUIRES_SYSCALL_CHECK([pivot_root], 
 AM_CONDITIONAL([BUILD_PIVOT_ROOT], [test "x$build_pivot_root" = xyes])
 
 
-UL_BUILD_INIT([flock], [yes])
+UL_BUILD_INIT([flock], [no])
 UL_REQUIRES_HAVE([flock], [timer], [timer_create function])
 AM_CONDITIONAL([BUILD_FLOCK], [test "x$build_flock" = xyes])
 
