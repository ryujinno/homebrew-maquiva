require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'http://www.kernel.org/pub/linux/utils/util-linux/v2.28/util-linux-2.28.2.tar.xz'
  sha256   'b89d37146f20bede93a42c847bce881a17e6dbd8066ff2db2bee733fa409f0cd'

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

