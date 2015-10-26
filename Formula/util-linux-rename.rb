require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'http://www.kernel.org/pub/linux/utils/util-linux/v2.27/util-linux-2.27.tar.gz'
  sha256   '21ede7eb6c3a2a9c7b13eeee241e82428be4f6d5030ff488f638817f419af093'

  depends_on :autoconf
  depends_on :automake

  patch do
    url    'https://raw.githubusercontent.com/ryujinno/homebrew-makiba/master/patch/util-linux-rename/util-linux-2.27-no_use_flock.patch'
    sha256 '1da3657f93a087c6926412bf0e71c299645e3ea63136a6a9d30af91fbc607594'
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

