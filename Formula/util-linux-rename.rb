require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'http://www.kernel.org/pub/linux/utils/util-linux/v2.28/util-linux-2.28.1.tar.xz'
  sha256   '3ece4ea4a34ef786b68f5c415e848390424232abd1ee00f7ee5bddc30657b60f'

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

