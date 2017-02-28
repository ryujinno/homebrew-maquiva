require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'https://www.kernel.org/pub/linux/utils/util-linux/v2.29/util-linux-2.29.2.tar.xz'
  sha256   'accea4d678209f97f634f40a93b7e9fcad5915d1f4749f6c47bee6bf110fe8e3'

  depends_on 'pkg-config' => :build

  def install
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

