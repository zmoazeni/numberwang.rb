require_relative 'numberwang_service'
require 'byebug'

RSpec.describe NumberwangService do
  context 'single assertions' do
    before do
      @numberwang = NumberwangService.new
      @wangernumb = NumberwangService.new(wangernumb_round: true)
    end

    context 'numberwangs' do
      it '50 is a safe first number' do
        expect { @numberwang.choose(50) }.not_to raise_error
      end

      it '1 is a safe first number' do
        expect { @numberwang.choose(1) }.not_to raise_error
      end

      it '27 then 30 is safe' do
        @numberwang.choose(27)
        expect { @numberwang.choose(30) }.not_to raise_error
      end

      it '8.2 then 4 numberwangs' do
        @numberwang.choose(8.2)
        expect { @numberwang.choose(4) }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it '4 then 6 does not numberwang' do
        @numberwang.choose(4)
        expect { @numberwang.choose(6) }.not_to raise_error
      end

      it '8 - 4 numberwangs' do
        expect { @numberwang.choose("8 - 4") }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it '8-4 numberwangs' do
        expect { @numberwang.choose("8-4") }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it '18 then 54 numberwangs' do
        @numberwang.choose(18)
        expect { @numberwang.choose(54) }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it '6 then 2.4 numberwangs' do
        @numberwang.choose(6)
        expect { @numberwang.choose(2.4) }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it 'sqrt(14) then 12 numberwangs' do
        @numberwang.choose('root 14')
        expect { @numberwang.choose(12) }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it '109 * 17 numberwangs' do
        expect { @numberwang.choose('109 * 17') }.to raise_error(NumberwangService::ThatsNumberwang)
      end
    end

    context 'wangernumbs' do
      it "8x 1s triggers wangernumb if we're in wangernumb round" do
        seven_1s = 7.times.map { 1 }
        @wangernumb.choose(*seven_1s)
        expect { @wangernumb.choose(1) }.to raise_error(NumberwangService::ThatsWangernumb)
      end

      it "8x 1s doesn't trigger wangernumb if we're not in wangernumb round" do
        seven_1s = 7.times.map { 1 }
        @numberwang.choose(*seven_1s)
        expect { @numberwang.choose(1) }.not_to raise_error
      end
    end
  end

  context 'single focus' do
    context 'numberwang' do
      it 'known numberwangs' do
        expect { numberwang.choose(*[3, 9, 16, 12, 8.2, 4]) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*[27, 30, 18, 54]) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*[4, 6, 2.4]) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*['root 14', 12]) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*['8 - 4']) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*['109 * 17']) }.to raise_error(NumberwangService::ThatsNumberwang)
      end

      it 'ignores spacing for expressions' do
        expect { numberwang.choose(*['8 - 4']) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*['8-4']) }.to raise_error(NumberwangService::ThatsNumberwang)
        expect { numberwang.choose(*["8\n-\n4"]) }.to raise_error(NumberwangService::ThatsNumberwang)
      end
    end

    context 'wangernumb' do
      it '8x 1s triggers wangernumb' do
        seven_1s = 7.times.map { 1 }

        service = wangernumb
        service.choose(*seven_1s)
        expect { service.choose(1) }.to raise_error(NumberwangService::ThatsWangernumb)

        service = numberwang
        service.choose(*seven_1s)
        expect { service.choose(1) }.not_to raise_error
      end
    end

    def numberwang
      NumberwangService.new
    end

    def wangernumb
      NumberwangService.new(wangernumb_round: true)
    end
  end
end
