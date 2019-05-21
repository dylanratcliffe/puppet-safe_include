require 'spec_helper_acceptance'

def run_function(name, param)
  pp = <<-PUPPETCODE
    $return = #{name}('#{param}')

    file { '/result':
      ensure  => file,
      content => String.new($return),
    }
  PUPPETCODE

  idempotent_apply(pp)
  file('/result')
end

describe 'testing supporting functions' do
  describe 'checking class existence' do
    context 'when a class exists' do
      it 'returns true' do
        result = run_function('safe_include::class_exists', 'postgresql::server')

        expect(result).to contain 'true'
      end
    end

    context 'when a class doesn\'t exist' do
      it 'returns false' do
        result = run_function('safe_include::class_exists', 'postgresql::alkdjncsjkdncksdubc')

        expect(result).to contain 'false'
      end
    end
  end

  describe 'checking class location' do
    context 'with a class' do
      it 'works' do
        result = run_function('safe_include::class_location', 'postgresql::server')

        expect(result).to contain '/etc/puppetlabs/code/environments/production/modules/postgresql/manifests/server.pp'
      end
    end
  end
end
